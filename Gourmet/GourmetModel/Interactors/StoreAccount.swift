//
//  StoreAccount.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public protocol StoreAccountListener : NSObjectProtocol {
    func onFinish(interactor: StoreAccount)
}

public class StoreAccount : NSObject {
    
    internal static let AccountKey = "AccountKey"
    
    private var account : Account?
    private weak var listener : StoreAccountListener?
    
    public func setAccount (account : Account?) {
        self.account = account
    }
    
    public func setListener (listener : StoreAccountListener) {
        self.listener = listener
    }
    
    public func execute () {
        DispatchQueue.global(qos: .background).async {
            let defaults = UserDefaults.init(suiteName: "group.atenea.gourmet")
            var data : Data?
            if let ac = self.account {
                data = NSKeyedArchiver.archivedData(withRootObject: ac)
            }
            
            defaults?.set(data, forKey: "account")
            
            DispatchQueue.main.async {
                self.listener?.onFinish(interactor: self)
                self.notifyAccountChange(account: self.account)
            }
        }
    }
    
    private func notifyAccountChange (account : Account?) {
        let center = NotificationCenter.default
        var userInfo : [AnyHashable : Any] = [:]
        if (account != nil) {
            userInfo[StoreAccount.AccountKey] = account!
        }
        
        center.post(name: .storedAccountUpdated, object: nil, userInfo: userInfo)
    }
}

extension Notification.Name {
    static let storedAccountUpdated = Notification.Name("StoreAccountUpdatedNotificationId")
}
