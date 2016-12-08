//
//  LoginPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol MainPresenterInterface {
    
    func updateView (view : MainView)
    
}

class MainPresenter : NSObject, MainPresenterInterface {
    
    private var storedAccount : GetStoredAccount!
    private var mapper : MapAccountToAccountVM!
    
    init(
        storedAccountInteractor : GetStoredAccount,
        mapper : MapAccountToAccountVM) {
        
        storedAccount = storedAccountInteractor
        self.mapper = mapper
    }
    
    func updateView(view: MainView) {
        storedAccount.execute { [unowned self] (account : Account?) in
            if (account == nil) {
                view.showNoAccount()
            } else {
                let accountVM = self.mapper.map(source: account!)!
                view.showAccountInfo(account: accountVM)
            }
        }
    }
    
}
