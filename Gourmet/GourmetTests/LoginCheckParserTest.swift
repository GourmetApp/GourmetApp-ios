//
//  LoginCheckParserTest.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import XCTest
@testable import Gourmet

class LoginCheckParserTest: XCTestCase, LoginCheckParseListener {
    
    private var responseArrived : XCTestExpectation?
    private var response : ResponseLogin?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldReadXmlInformationIfPresent() {
        
        let result = "<?xml version='1.0' encoding='UTF-8'?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body><ns2:consultaUsuariosResponse xmlns:ns2=\"http://ws.tarjetaWeb.gourmet.com/\"><return><codReq>-1</codReq><desReq>tarjeta no existe</desReq></return></ns2:consultaUsuariosResponse></S:Body></S:Envelope>"
        let data = result.data(using: String.Encoding.utf8)
        let inputStream = InputStream(data: data!)
        
        responseArrived = expectation(description: "Waiting for XMLParser")
        let parser = LoginCheckParser()
        parser.setListener(listener: self)
        parser.parse(inputStream: inputStream)
        
        waitForExpectations(timeout: 3.0) { (error: Error?) in
            XCTAssertEqual(self.response?.code, -1)
            XCTAssertEqual(self.response?.message, "tarjeta no existe")
        }
        
    }
    
    internal func onSuccess(parser: LoginCheckParser, response: ResponseLogin) {
        self.response = response
        
        responseArrived?.fulfill()
    }
    
    internal func onError(parser: LoginCheckParser) {
        responseArrived?.fulfill()
    }
}
