//
//  StoreAccount.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol StoreAccountListener : NSObjectProtocol {
    func onFinish(interactor: StoreAccount)
}

class StoreAccount : NSObject {
    
    private var account : Account?
    private weak var listener : StoreAccountListener?
    
    func setAccount (account : Account?) {
        self.account = account
    }
    
    func setListener (listener : StoreAccountListener) {
        self.listener = listener
    }
    
    func execute () {
        DispatchQueue.global(qos: .background).async {
            let defaults = UserDefaults.init(suiteName: "com.atenea.gourmet.appgroup")
            var data : Data?
            if let ac = self.account {
                data = NSKeyedArchiver.archivedData(withRootObject: ac)
            }
            
            defaults?.set(data, forKey: "account")
            self.listener?.onFinish(interactor: self)
        }
    }
    
}
