//
//  Purchase.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public class Purchase : NSObject, NSCoding {
    
    public enum PurchaseType : Int {
        case charge = 0
        case spend = 1
    }
    
    public var date : Date!
    public var type : PurchaseType = .spend
    public var quantity : String = "0.00"
    public var commerce : String = ""
    public var location : String = ""
    
    override
    public init() {
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(date.timeIntervalSinceReferenceDate, forKey: "date")
        aCoder.encode(type.rawValue, forKey: "type")
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(commerce, forKey: "commerce")
        aCoder.encode(location, forKey: "location")
    }
    
    required
    public init?(coder aDecoder: NSCoder) {
        date = Date(timeIntervalSinceReferenceDate: aDecoder.decodeDouble(forKey: "date"))
        type = PurchaseType(rawValue: aDecoder.decodeInteger(forKey: "type")) ?? .spend
        quantity = aDecoder.decodeObject(forKey: "quantity") as? String ?? "0.00"
        commerce = aDecoder.decodeObject(forKey: "commerce") as? String ?? ""
        location = aDecoder.decodeObject(forKey: "location") as? String ?? ""
    }
    
}
