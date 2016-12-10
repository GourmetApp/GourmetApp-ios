//
//  LoginCheck.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol LoginCheckListener : NSObjectProtocol {
    func onSuccess (account : Account)
    func onError(error : LoginCheck.ErrorType)
}

class LoginCheck : NSObject {
    
    enum ErrorType : Error {
        case noError
        case cardIdNotExists
        case passwordInvalid
        case unknown
    }
    
    private weak var listener : LoginCheckListener?
    private var account : Account?
    
    func setListener (listener : LoginCheckListener?) {
        self.listener = listener
    }
    
    func setAccount (account : Account) {
        self.account = account
    }
    
    func execute () {
        guard listener != nil else {
            print("A listener must be set to LoginCheck interactor")
            return
        }
        
        guard account != nil else {
            print("An account must be set to LoginCheck interactor")
            return
        }
        
        // TODO: Server Communication
    }
    
    func execute (account : Account, callback : (_ account: Account, _ error : LoginCheck.ErrorType) -> Void) {
        // TODO: Server Communication
    }
    
}
