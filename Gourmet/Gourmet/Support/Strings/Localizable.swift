//
//  Localizable.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class Localizable: NSObject {

    private static let stringFile = "App"
    
    static func getString (key : String) -> String {
        return NSLocalizedString(key,
                                 tableName: Localizable.stringFile,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
    
}
