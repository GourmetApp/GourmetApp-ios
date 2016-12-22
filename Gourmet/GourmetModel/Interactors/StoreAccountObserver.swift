//
//  StoreAccountObserver.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public protocol StoreAccountObserverListener : NSObjectProtocol {
    
    func onChange(observer: StoreAccountObserver, account : Account?)
    
}

public class StoreAccountObserver : NSObject {
    
    private weak var listener : StoreAccountObserverListener?
    private var observer : NSObjectProtocol?
    
    public func setListener (listener: StoreAccountObserverListener?) {
        self.listener = listener
    }
    
    public func execute () {
        let center = NotificationCenter.default
        if (observer != nil) {
            center.removeObserver(observer!)
        }
        
        observer = center.addObserver(
            forName: .storedAccountUpdated,
            object: nil,
            queue: OperationQueue.main,
            using: { (notification : Notification) in
                let account = notification.userInfo?[StoreAccount.AccountKey] as? Account
                self.onAccountChange(account: account)
            }
        )
    }
    
    deinit {
        let center = NotificationCenter.default
        if (observer != nil) {
            center.removeObserver(observer!)
        }
    }
    
    private func onAccountChange (account : Account?) {
        self.listener?.onChange(observer: self, account: account)
    }
    
}
