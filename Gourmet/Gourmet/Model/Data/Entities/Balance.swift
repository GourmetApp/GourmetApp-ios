//
//  Balance.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public class Balance : NSObject, NSCoding {
    
    public var quantity : String = "0.00"
    public var requestDate : Date!
    public var lastPurchases : [Purchase] = []
    
    override
    public init() {
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(requestDate.timeIntervalSinceReferenceDate, forKey: "requestDate")
        aCoder.encode(lastPurchases, forKey: "lastPurchases")
    }
    
    required
    public init?(coder aDecoder: NSCoder) {
        super.init()
        
        quantity = aDecoder.decodeObject(forKey: "quantity") as? String ?? "0.00"
        requestDate = Date(timeIntervalSinceReferenceDate: aDecoder.decodeDouble(forKey: "requestDate"))
        lastPurchases = aDecoder.decodeObject(forKey: "lastPurchases") as? [Purchase] ?? []
    }

}
