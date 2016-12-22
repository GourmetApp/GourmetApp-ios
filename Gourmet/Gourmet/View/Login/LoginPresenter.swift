//
//  LoginPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation
import GourmetModel

class LoginPresenter : NSObject, GetStoredAccountListener,
LoginCheckListener {
    
    private weak var view : LoginView?
    
    private var storedGetAccount : GetStoredAccount!
    private var storeAccount : StoreAccount!
    private var loginChecker : LoginCheck!
    private var accountMapper : MapAccountToAccountVM!
    
    // MARK: Lifecycle
    init(interactorGet : GetStoredAccount,
         interactorPost : StoreAccount,
         interactorLogin : LoginCheck,
         mapper : MapAccountToAccountVM) {
        
        super.init()
        storedGetAccount = interactorGet
        storedGetAccount.setListener(listener: self)
        loginChecker = interactorLogin
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
        loginChecker.setListener(listener: self)
        let account = Account(cardId: account.cardId, password: account.password)
        loginChecker.setAccount(account: account)
        loginChecker.setListener(listener: self)
        loginChecker.execute()
    }
    
    func unlink (account : AccountVM) {
        storeAccount.setAccount(account: nil)
        storeAccount.execute()
    }
    
    // MARK: GetStoredAccountListener
    func onFinish(interactor: GetStoredAccount, account: Account?) {
        guard account != nil else { return }
        let accountVM = accountMapper.map(source: account!)
        
        view?.showAccount(account: accountVM)
    }
    
    // MARK: LoginCheckListener
    func onSuccess(caller: LoginCheck, account: Account) {
        
    }
    
    func onError(caller: LoginCheck, error: LoginCheck.ErrorType) {
        loginChecker.setListener(listener: nil)
        
        DispatchQueue.main.async { [weak self] in
            if error == LoginCheck.ErrorType.cardIdNotExists {
                self?.view?.showError(message: Localizable.getString(key: "login_error_cardid_not_exists"))
            } else if error == LoginCheck.ErrorType.passwordInvalid {
                self?.view?.showError(message: Localizable.getString(key: "login_error_password_invalid"))
            } else {
                self?.view?.showError(message: Localizable.getString(key: "login_error_connection_unknown"))
            }
        }
    }
}
