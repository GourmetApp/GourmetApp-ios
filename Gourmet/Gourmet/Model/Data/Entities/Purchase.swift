//
//  Purchase.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class Purchase : NSObject, NSCoding {
    
    enum PurchaseType : Int {
        case charge = 0
        case spend = 1
    }
    
    var date : Date!
    var type : PurchaseType = .spend
    var quantity : Double = 0.0
    var commerce : String = ""
    var location : String = ""
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date.timeIntervalSinceReferenceDate, forKey: "date")
        aCoder.encode(type.rawValue, forKey: "type")
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(commerce, forKey: "commerce")
        aCoder.encode(location, forKey: "location")
    }
    
    required init?(coder aDecoder: NSCoder) {
        date = Date(timeIntervalSinceReferenceDate: aDecoder.decodeDouble(forKey: "date"))
        type = PurchaseType(rawValue: aDecoder.decodeInteger(forKey: "type")) ?? .spend
        quantity = aDecoder.decodeDouble(forKey: "quantity")
        commerce = aDecoder.decodeObject(forKey: "commerce") as? String ?? ""
        location = aDecoder.decodeObject(forKey: "location") as? String ?? ""
    }
    
}