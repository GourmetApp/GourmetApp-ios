//
//  GetAccount.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class GetStoredAccount : NSObject {
    
    func execute (callback : @escaping (_ account : Account?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let defaults = UserDefaults.init(suiteName: "com.atenea.gourmet.appgroup")
            var account : Account?
            if let accountData = defaults!.data(forKey: "account") {
                account = NSKeyedUnarchiver.unarchiveObject(with: accountData) as? Account
            }
            
            DispatchQueue.main.async {
                callback(account)
            }
        }
    }
    
}
