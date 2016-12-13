//
//  LoginCheckParser.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol LoginCheckParseListener : NSObjectProtocol {
    
    func onSuccess (parser: LoginCheckParser, response: ResponseLogin)
    func onError (parser: LoginCheckParser)
    
}

class LoginCheckParser : NSObject, XMLParserDelegate {
    
    private static let CODE_KEY = "codReq"
    private static let MESSAGE_KEY = "desReq"
    
    private weak var listener : LoginCheckParseListener?
    
    private var reader : Reader?
    private var elementValue : String?
    
    // MARK: Services
    func setListener (listener : LoginCheckParseListener?) {
        self.listener = listener
    }
    
    func execute (inputStream : InputStream) {
        let parser = XMLParser(stream: inputStream)
        
        reader = Reader()
        parser.delegate = self
        parser.parse()
    }
    
    func execute (contentsOfFile url : URL) {
        guard let stream = InputStream(url: url) else {
            listener?.onError(parser: self)
            return
        }
        
        execute(inputStream: stream)
    }
    
    // MARK: XMLParserDelegate
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        elementValue = String()
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        elementValue?.append(string)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementValue != nil else { return }
        
        if (elementName == LoginCheckParser.CODE_KEY) {
            reader?.codeId = Int(elementValue!)
        } else if (elementName == LoginCheckParser.MESSAGE_KEY) {
            reader?.message = elementValue!
        }
        
        elementValue = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        guard reader?.codeId != nil else {
            listener?.onError(parser: self)
            return
        }
        
        guard reader?.message != nil else {
            listener?.onError(parser: self)
            return
        }
        
        let response = ResponseLogin()
        response.code = (reader?.codeId)!
        response.message = (reader?.message)!
        
        DispatchQueue.main.async {
            self.listener?.onSuccess(parser: self, response: response)
        }
    }
    
    // MARK: Holder class
    private class Reader : NSObject {
        var codeId : Int?
        var message : String?
    }
}
