//
//  BalanceParserTest.swift
//  Gourmet
//
//  Created by David Martinez on 13/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import XCTest
@testable import Gourmet

class BalanceParserTest: XCTestCase, BalanceParseListener {

    private var responseArrived : XCTestExpectation?
    private var response : Balance?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldReadXmlInformationIfPresent() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "BalanceResponseOk", ofType: "xml") else {
            XCTFail()
            return
        }
        
        var contents : String?
        do {
            contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
        } catch {
            XCTFail()
        }
        
        let data = contents!.data(using: String.Encoding.utf8)
        let inputStream = InputStream(data: data!)
        
        responseArrived = expectation(description: "Waiting for XMLParser")
        let parser = BalanceParser()
        parser.setListener(listener: self)
        parser.execute(inputStream: inputStream)
        
        waitForExpectations(timeout: 3.0) { (error: Error?) in
            XCTAssertEqual(self.response?.quantity, "196.75")
            XCTAssertEqual(self.response?.lastPurchases.count, 9)
            
            let stringDate = "12/12/2016 22:42"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let date = dateFormatter.date(from: stringDate)
            
            let purchase = (self.response?.lastPurchases.first)!
            XCTAssertEqual(purchase.commerce, "KILOMETROS DE PIZZA M")
            XCTAssertEqual(purchase.location, "")
            XCTAssertEqual(purchase.type, .spend)
            XCTAssertEqual(purchase.date, date)
            XCTAssertEqual(purchase.quantity, "26.00")
        }
    }
    
    func onSuccess(parser: BalanceParser, response: Balance) {
        self.response = response
        responseArrived?.fulfill()
    }
    
    func onError(parser: BalanceParser) {
        responseArrived?.fulfill()
    }
}
