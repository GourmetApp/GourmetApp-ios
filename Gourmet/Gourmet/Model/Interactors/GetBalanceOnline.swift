//
//  GetBalanceOnline.swift
//  Gourmet
//
//  Created by David Martinez on 13/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol GetBalanceOnlineListener : NSObjectProtocol {
    
    func onFinish (getBalanceOnline: GetBalanceOnline, balance : Balance?)
    
}

class GetBalanceOnline: NSObject, BalanceParserListener {
    
    private var parseBalance : BalanceParser!
    private var dm : GourmetServiceDM!
    private weak var listener : GetBalanceOnlineListener?
    
    init(parseBalance : BalanceParser,
         dm : GourmetServiceDM) {
        
        super.init()
        
        self.parseBalance = parseBalance
        self.dm = dm
        
        parseBalance.setListener(listener: self)
    }
    
    func setListener (listener : GetBalanceOnlineListener?) {
        self.listener = listener
    }
    
    func execute(account : Account) {
        dm.getBalance(account: account) { [weak self] (url: URL?, error: Error?) in
            guard let mySelf = self else { return }
            
            if (error != nil) {
                mySelf.listener?.onFinish(getBalanceOnline: mySelf, balance: nil)
            } else {
                mySelf.parseBalance.execute(contentsOfFile: url!)
            }
        }
    }
    
    // MARK: BalanceParserListener
    func onSuccess(parser: BalanceParser, response: Balance) {
        response.requestDate = Date()
        listener?.onFinish(getBalanceOnline: self, balance: response)
    }
    
    func onError(parser: BalanceParser) {
        listener?.onFinish(getBalanceOnline: self, balance: nil)
    }
}
