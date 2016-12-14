//
//  GetBalanceOffline.swift
//  Gourmet
//
//  Created by David Martinez on 13/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol GetBalanceOfflineListener : NSObjectProtocol {
    
    func onFinish (getBalanceOffline: GetBalanceOffline, balance : Balance?)
    
}

class GetBalanceOffline: NSObject {

    private weak var listener : GetBalanceOfflineListener?
    
    func setListener (listener : GetBalanceOfflineListener?) {
        self.listener = listener
    }
    
    func execute() {
        listener?.onFinish(getBalanceOffline: self, balance: nil)
        // TODO:
    }
    
}
