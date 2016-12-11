//
//  ResponseLogin.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class ResponseLogin : NSObject {
    
    static let INVALID_ID = -1
    static let INVALID_PASSWORD = 2
    static let VALID_ID = 1
    
    var code : Int = ResponseLogin.VALID_ID
    var message : String = ""
    
}
