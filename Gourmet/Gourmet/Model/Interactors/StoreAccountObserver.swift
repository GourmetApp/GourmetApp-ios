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
    
    public func setListener (listener: StoreAccountObserverListener?) {
        self.listener = listener
    }
    
    public func execute () {
        let defaults = UserDefaults.init(suiteName: "group.atenea.gourmet")
        defaults?.addObserver(self, forKeyPath: "account", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    deinit {
        let defaults = UserDefaults.init(suiteName: "group.atenea.gourmet")
        defaults?.removeObserver(self, forKeyPath: "account")
    }
    
    override
    public func observeValue (
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
        
        guard let accountKey = keyPath else { return }
        let userDefaults = object as? UserDefaults
        var account : Account?
        if let accountData = userDefaults?.data(forKey: accountKey) {
            account = NSKeyedUnarchiver.unarchiveObject(with: accountData) as? Account
        }
        
        if (Thread.isMainThread) {
            self.listener?.onChange(observer: self, account: account)
        }
    }
    
}
