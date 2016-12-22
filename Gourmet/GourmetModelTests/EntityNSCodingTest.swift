//
//  EntityNSCodingTest.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import XCTest
@testable import Gourmet
@testable import GourmetModel

class EntityNSCodingTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAccount() {
        let account = Account(cardId: "1", password: "2")
        let accountData = NSKeyedArchiver.archivedData(withRootObject: account)
        let accountParse = NSKeyedUnarchiver.unarchiveObject(with: accountData) as? Account
        XCTAssertNotNil(accountParse)
        XCTAssertEqual(accountParse?.cardId, account.cardId)
        XCTAssertEqual(accountParse?.password, account.password)
    }
    
    func testPurchase() {
        let purchase = Purchase()
        purchase.date = Date()
        purchase.commerce = "1"
        purchase.quantity = "150.0"
        purchase.location = "here"
        purchase.type = .charge
        
        let purchaseData = NSKeyedArchiver.archivedData(withRootObject: purchase)
        let purchaseParse = NSKeyedUnarchiver.unarchiveObject(with: purchaseData) as? Purchase
        
        XCTAssertNotNil(purchaseParse)
        XCTAssertEqual(purchaseParse!.date, purchase.date)
        XCTAssertEqual(purchaseParse!.commerce, purchase.commerce)
        XCTAssertEqual(purchaseParse!.quantity, purchase.quantity)
        XCTAssertEqual(purchaseParse!.location, purchase.location)
        XCTAssertEqual(purchaseParse!.type, purchase.type)
    }
    
    func testBalance() {
        let purchase1 = Purchase()
        purchase1.date = Date()
        purchase1.commerce = "1"
        purchase1.quantity = "150.0"
        purchase1.location = "here"
        purchase1.type = .charge
        
        let purchase2 = Purchase()
        purchase2.date = Date()
        purchase2.commerce = "2"
        purchase2.quantity = "250.0"
        purchase2.location = "here 2"
        purchase2.type = .spend
        
        let purchases = [purchase1, purchase2]
        let balance = Balance()
        balance.quantity = "400.0"
        balance.lastPurchases = purchases
        balance.requestDate = Date()
        
        let balanceData = NSKeyedArchiver.archivedData(withRootObject: balance)
        let balanceParse = NSKeyedUnarchiver.unarchiveObject(with: balanceData) as? Balance
        
        XCTAssertNotNil(balanceParse)
        XCTAssertEqual(balanceParse?.quantity, balance.quantity)
        XCTAssertEqual(balanceParse?.lastPurchases.count, balance.lastPurchases.count)
    }
}
