//
//  GetAccountInfo.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

public protocol GetBalanceListener : NSObjectProtocol {
    
    func onSuccess (balance : Balance)
    func onError ()
    
}

public class GetBalance : NSObject, GetBalanceOfflineListener, GetBalanceOnlineListener {
    
    private var getBalanceOffline : GetBalanceOffline!
    private var getBalanceOnline : GetBalanceOnline!
    private var storeBalance : StoreBalance!
    private weak var listener : GetBalanceListener?
    
    private var account : Account!
    
    public init(getBalanceOffline : GetBalanceOffline,
         getBalanceOnline : GetBalanceOnline,
         storeBalance : StoreBalance) {
        
        super.init()
        
        self.getBalanceOffline = getBalanceOffline
        self.getBalanceOnline = getBalanceOnline
        self.storeBalance = storeBalance
        
        getBalanceOffline.setListener(listener: self)
        getBalanceOnline.setListener(listener: self)
        
    }
    
    public func setListener (listener : GetBalanceListener) {
        self.listener = listener
    }
    
    public func execute (account : Account) {
        self.account = account
        getBalanceOffline.execute()
    }
    
    // MARK: GetBalanceOfflineListener
    public func onFinish(getBalanceOffline: GetBalanceOffline, balance: Balance?) {
        guard listener != nil else { return }
        
        if (balance != nil) {
            listener!.onSuccess(balance: balance!)
        }
        
        getBalanceOnline.execute(account: account)
    }
    
    // MARK: GetBalanceOnlineListener
    public func onFinish(getBalanceOnline: GetBalanceOnline, balance: Balance?) {
        guard listener != nil else { return }
        
        if (balance != nil) {
            DispatchQueue.main.async {
                self.listener!.onSuccess(balance: balance!)
            }
            storeBalance.execute(balance: balance!)
        } else {
            DispatchQueue.main.async {
                self.listener!.onError()
            }
        }
    }
}
