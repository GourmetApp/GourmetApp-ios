//
//  Account.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public class Account : NSObject, NSCoding {
    
    public var cardId : String = ""
    public var password : String = ""
    
    override
    public init() {
        
    }
    
    public init(cardId : String, password : String) {
        self.cardId = cardId
        self.password = password
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(cardId, forKey: "cardId")
        aCoder.encode(password, forKey: "password")
    }
    
    required
    public init?(coder aDecoder: NSCoder) {
        super.init()
        
        cardId = aDecoder.decodeObject(forKey: "cardId") as? String ?? ""
        password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
    }
}
