//
//  LoginPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class LoginPresenter : NSObject, GetStoredAccountListener {
    
    private weak var view : LoginView?
    
    private var storedGetAccount : GetStoredAccount!
    private var storeAccount : StoreAccount!
    private var accountMapper : MapAccountToAccountVM!
    
    // MARK: Lifecycle
    init(interactorGet : GetStoredAccount,
         interactorPost : StoreAccount,
         mapper : MapAccountToAccountVM) {
        
        super.init()
        storedGetAccount = interactorGet
        storedGetAccount.setListener(listener: self)
        storeAccount = interactorPost
        accountMapper = mapper
    }
    
    // MARK: Services
    func bind (view : LoginView) {
        self.view = view
        loadAccount()
    }
    
    private func loadAccount () {
        storedGetAccount.setListener(listener: self)
        storedGetAccount.execute()
    }
    
    func login (account : AccountVM) {
        // TODO:
    }
    
    func unlink (account : AccountVM) {
        storeAccount.setAccount(account: nil)
        storeAccount.execute()
    }
    
    // MARK: GetStoredAccountListener
    func onFinish(interactor: GetStoredAccount, account: Account?) {
        guard account != nil else { return }
        guard let accountVM = accountMapper.map(source: account!) else { return }
        
        DispatchQueue.main.async {
            self.view?.showAccount(account: accountVM)
        }
    }
}
