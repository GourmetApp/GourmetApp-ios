//
//  Purchase.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class Purchase : NSObject {
    
    enum PurchaseType {
        case charge
        case spend
    }
    
    var date : Date!
    var type : PurchaseType = .spend
    var quantity : Double = 0.0
    var commerce : String = ""
    var location : String = ""
    
}
