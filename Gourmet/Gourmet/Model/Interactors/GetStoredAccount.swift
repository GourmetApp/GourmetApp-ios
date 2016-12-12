//
//  GetAccount.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

@objc protocol GetStoredAccountListener {
    func onFinish (interactor : GetStoredAccount, account : Account?)
}

class GetStoredAccount : NSObject {
    
    private weak var listener : GetStoredAccountListener?
    
    func setListener (listener : GetStoredAccountListener?) {
        self.listener = listener
    }
    
    func execute () {
        DispatchQueue.global(qos: .background).async {
            let defaults = UserDefaults.init(suiteName: "com.atenea.gourmet.appgroup")
            var account : Account?
            if let accountData = defaults!.data(forKey: "account") {
                account = NSKeyedUnarchiver.unarchiveObject(with: accountData) as? Account
            }
            
            DispatchQueue.main.async { [weak self] in
                guard self != nil else { return }
                self!.listener?.onFinish(interactor: self!, account: account)
            }
        }
    }
}
