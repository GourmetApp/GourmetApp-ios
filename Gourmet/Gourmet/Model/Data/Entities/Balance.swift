//
//  Balance.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class Balance : NSObject, NSCoding {
    
    var quantity : Double = 0.0
    var lastPurchases : [Purchase] = []
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(lastPurchases, forKey: "lastPurchases")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        quantity = aDecoder.decodeDouble(forKey: "quantity")
        lastPurchases = aDecoder.decodeObject(forKey: "lastPurchases") as? [Purchase] ?? []
    }

}
