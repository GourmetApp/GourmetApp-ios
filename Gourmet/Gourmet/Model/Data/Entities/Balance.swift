//
//  Balance.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class Balance : NSObject, NSCoding {
    
    var quantity : String = "0.00"
    var requestDate : Date!
    var lastPurchases : [Purchase] = []
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(requestDate.timeIntervalSinceReferenceDate, forKey: "requestDate")
        aCoder.encode(lastPurchases, forKey: "lastPurchases")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        quantity = aDecoder.decodeObject(forKey: "quantity") as? String ?? "0.00"
        requestDate = Date(timeIntervalSinceReferenceDate: aDecoder.decodeDouble(forKey: "requestDate"))
        lastPurchases = aDecoder.decodeObject(forKey: "lastPurchases") as? [Purchase] ?? []
    }

}
