//
//  SignUpPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 09/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation
import GourmetModel

class SignUpPresenter : NSObject, LoginCheckListener {
    
    private var loginChecker : LoginCheck!
    private var accountMapper : MapAccountToAccountVM!
    private weak var view : SignUpView?
    private var isLoading = false
    
    init(loginCheckInteractor : LoginCheck, mapper : MapAccountToAccountVM) {
        accountMapper = mapper
        loginChecker = loginCheckInteractor
    }
    
    func signUp (cardId : String?, password : String?, view : SignUpView) {
        if (isLoading) {
            return
        }
        
        guard cardId != nil && cardId!.characters.count != 0 else {
            view.showError(message: Localizable.getString(key: "signup_error_cardid_empty"))
            return
        }
        
        let components = cardId!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let cardIdParsed = components.joined(separator: "")
        
        guard cardIdParsed.characters.count == 16 else {
            view.showError(message: Localizable.getString(key: "signup_error_cardid_malformed"))
            return
        }
        
        guard password != nil && password!.characters.count != 0 else {
            view.showError(message: Localizable.getString(key: "signup_error_password_empty"))
            return
        }
        
        isLoading = true
        
        self.view = view
        view.showLoading()
        
        let account = Account(cardId: cardIdParsed, password: password!)
        loginChecker.setAccount(account: account)
        loginChecker.setListener(listener: self)
        loginChecker.execute()
    }
    
    // MARK: LoginCheckListener
    internal func onSuccess(caller: LoginCheck, account: Account) {
        isLoading = false
        loginChecker.setListener(listener: nil)
        view?.hideLoading()
        
        let accountVM = accountMapper.map(source: account)
        view?.showAccount(account: accountVM)
    }
    
    internal func onError(caller: LoginCheck, error: LoginCheck.ErrorType) {
        isLoading = false
        loginChecker.setListener(listener: nil)
        view?.hideLoading()
        
        if error == LoginCheck.ErrorType.cardIdNotExists {
            view?.showError(message: Localizable.getString(key: "signup_error_cardid_not_exists"))
        } else if error == LoginCheck.ErrorType.passwordInvalid {
            view?.showError(message: Localizable.getString(key: "signup_error_password_invalid"))
        } else {
            view?.showError(message: Localizable.getString(key: "signup_error_connection_unknown"))
        }
    }
    
}
