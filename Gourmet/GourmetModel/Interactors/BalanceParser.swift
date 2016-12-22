//
//  BalanceParser.swift
//  Gourmet
//
//  Created by David Martinez on 13/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

public protocol BalanceParserListener : NSObjectProtocol {
    
    func onSuccess (parser: BalanceParser, response: Balance)
    func onError (parser: BalanceParser)
    
}

public class BalanceParser: NSObject, XMLParserDelegate {

    private static let readingNone = 0
    private static let readyToReadBalance = 1
    private static let readingBalance = 2
    private static let readyToReadPurchases = 4
    private static let readingPurchase = 5
    private static let readingCommerce = 6
    private static let readingDate = 7
    private static let readingHour = 8
    private static let readingQuantity = 9
    private static let readingType = 10
    private static let closingPurchase = 100
    
    private var readingType = BalanceParser.readingNone
    
    private weak var listener : BalanceParserListener?
    
    private var balance : Balance!
    private var elementValue : String?
    
    private var purchase : Purchase!
    private var dateField1 : String = ""
    private var dateField2 : String = ""
    
    // MARK: Services
    public func setListener (listener : BalanceParserListener?) {
        self.listener = listener
    }
    
    public func execute (inputStream : InputStream) {
        let parser = XMLParser(stream: inputStream)
        
        balance = Balance()
        parser.delegate = self
        parser.parse()
    }
    
    public func execute (contentsOfFile url : URL) {
//        guard let stream = InputStream(url: url) else {
//            listener?.onError(parser: self)
//            return
//        }
//        
//        execute(inputStream: stream)
        
        do {
            let string = try String(contentsOf: url, encoding: String.Encoding.isoLatin1)
            guard let data = string.data(using: String.Encoding.utf8) else {
                listener?.onError(parser: self)
                return
            }
            
            let parser = XMLParser(data: data)
            parse(parser: parser)
        } catch {
            print ("\(error)")
            listener?.onError(parser: self)
        }
    }
    
    private func parse (parser : XMLParser) {
        balance = Balance()
        parser.delegate = self
        parser.parse()
    }
    
    // MARK: XMLParser
    public func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        if (elementName == "div" && attributeDict["id"] == "TotalSaldo") {
            readingType = BalanceParser.readyToReadBalance
        } else if (readingType == BalanceParser.readyToReadBalance && elementName == "strong") {
            readingType = BalanceParser.readingBalance
            elementValue = String()
        } else if (elementName == "table" && attributeDict["id"] == "tablaMovimientos") {
            readingType = BalanceParser.readyToReadPurchases
        } else if (readingType == BalanceParser.readyToReadPurchases && elementName == "tr") {
            readingType = BalanceParser.readingPurchase
            purchase = Purchase()
        } else if (readingType == BalanceParser.readingPurchase && elementName == "td" && attributeDict["id"] == "fecha") {
            readingType = BalanceParser.readingDate
            elementValue = String()
        } else if (readingType == BalanceParser.readingPurchase && elementName == "td" && attributeDict["id"] == "horaOperacion") {
            readingType = BalanceParser.readingHour
            elementValue = String()
        } else if (readingType == BalanceParser.readingPurchase && elementName == "td" && attributeDict["id"] == "operacion") {
            readingType = BalanceParser.readingCommerce
            elementValue = String()
        } else if (readingType == BalanceParser.readingPurchase && elementName == "td" && attributeDict["id"] == "importe") {
            readingType = BalanceParser.readingQuantity
            elementValue = String()
        } else if (readingType == BalanceParser.readingPurchase && elementName == "td" && attributeDict["id"] == "tipoPan") {
            readingType = BalanceParser.readingType
            elementValue = String()
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        elementValue?.append(string)
    }
    
    public func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
        if (readingType == BalanceParser.readingBalance) {
            balance.quantity = getQuantityParsed(string: elementValue!)
            readingType = BalanceParser.readingNone
            
        } else if (readingType == BalanceParser.readingDate) {
            dateField1 = elementValue!
            readingType = BalanceParser.readingPurchase
            
        } else if (readingType == BalanceParser.readingHour) {
            dateField2 = elementValue!
            readingType = BalanceParser.readingPurchase
            
        } else if (readingType == BalanceParser.readingCommerce) {
            purchase.commerce = getTrim(string: elementValue ?? "")
            readingType = BalanceParser.readingPurchase
            
        } else if (readingType == BalanceParser.readingQuantity) {
            purchase.quantity = getQuantityParsed(string: elementValue!)
            readingType = BalanceParser.readingPurchase
            
        } else if (readingType == BalanceParser.readingType && elementValue != nil) {
            if (elementValue!.contains("Actualización") && elementValue!.contains("saldo")) {
                purchase.type = .charge
            }
            readingType = BalanceParser.readingPurchase
        } else if (readingType == BalanceParser.readingPurchase && elementName == "tr") {
            readingType = BalanceParser.readyToReadPurchases
            purchase.date = getDateFrom(date: dateField1, hour: dateField2)
            balance.lastPurchases.append(purchase)
        }
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        listener?.onSuccess(parser: self, response: balance)
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        listener?.onError(parser: self)
    }
    
    private func getQuantityParsed (string: String) -> String {
        let fractions = string.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({$0 != ""})
        return fractions.joined(separator: ".")
    }
    
    private func getTrim (string: String) -> String {
        let fractions = string.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({$0 != ""})
        return fractions.joined(separator: " ")
    }
    
    private func getDateFrom (date: String, hour: String) -> Date {
        let stringDate = "\(date) \(hour)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        return dateFormatter.date(from: stringDate) ?? Date()
    }
}
