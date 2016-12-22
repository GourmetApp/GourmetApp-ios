//
//  ResponseLogin.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public class ResponseLogin : NSObject {
    
    static public let INVALID_ID = -1
    static public let INVALID_PASSWORD = 2
    static public let VALID_ID = 1
    
    public var code : Int = ResponseLogin.VALID_ID
    public var message : String = ""
    
}
