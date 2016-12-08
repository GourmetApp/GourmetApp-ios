//
//  LoginPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol LoginPresenterInterface {
    
    func loadAccounts ()
    func openAccount (account : AccountVM)
    
}

class LoginPresenter : NSObject, LoginPresenterInterface {
    
    func loadAccounts() {
        // TODO:
    }
    
    func openAccount(account : AccountVM) {
        // TODO:
    }
    
}
