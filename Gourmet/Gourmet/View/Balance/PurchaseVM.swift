//
//  PurchaseVM.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class PurchaseVM : NSObject {
    
    enum PurchaseType : Int {
        case charge = 0
        case spend = 1
    }
    
    var date : Date!
    var type : PurchaseType = .spend
    var quantity : String = "0.00"
    var commerce : String = ""
    var location : String = ""
    
    override init() {
        
    }
    
}
