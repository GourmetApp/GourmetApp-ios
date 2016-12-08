//
//  Account.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class Account : NSObject, NSCoding {
    
    var cardId : String = ""
    var password : String = ""
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cardId, forKey: "cardId")
        aCoder.encode(password, forKey: "password")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        cardId = aDecoder.decodeObject(forKey: "cardId") as? String ?? ""
        password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
    }
}
