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

class MainPresenter : NSObject, MainPresenterInterface, GetStoredAccountListener {
    
    private var storedAccount : GetStoredAccount!
    private var mapper : MapAccountToAccountVM!
    
    private weak var view : MainView?
    
    init(storedAccountInteractor : GetStoredAccount,
         mapper : MapAccountToAccountVM) {
        
        super.init()
        storedAccount = storedAccountInteractor
        storedAccount.setListener(listener: self)
        self.mapper = mapper
    }
    
    func updateView(view: MainView) {
        self.view = view
        storedAccount.execute()
    }
    
    // MARK: GetStoredAccountListener
    func onFinish(interactor: GetStoredAccount, account: Account?) {
        if (account == nil) {
            view?.showNoAccount()
        } else {
            let accountVM = self.mapper.map(source: account!)!
            view?.showAccountInfo(account: accountVM)
        }
    }
}
