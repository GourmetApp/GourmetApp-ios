//
//  SignUpPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 09/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class SignUpPresenter : NSObject, LoginCheckListener {
    
    private var loginChecker : LoginCheck!
    private weak var view : SignUpView?
    
    init(loginCheckInteractor : LoginCheck) {
        loginChecker = loginCheckInteractor
    }
    
    func signUp (cardId : String?, password : String?, view : SignUpView) {
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
        
        self.view = view
        view.showLoading()
        
        let account = Account(cardId: cardId!, password: password!)
        loginChecker.setAccount(account: account)
        loginChecker.setListener(listener: self)
        loginChecker.execute()
    }
    
    // MARK: LoginCheckListener
    internal func onSuccess(caller: LoginCheck, account: Account) {
        loginChecker.setListener(listener: nil)
        
        DispatchQueue.main.async {
            // TODO: Navegar al visor
        }
    }
    
    internal func onError(caller: LoginCheck, error: LoginCheck.ErrorType) {
        loginChecker.setListener(listener: nil)
        
        DispatchQueue.main.async { [weak self] in
            if error == LoginCheck.ErrorType.cardIdNotExists {
                self?.view?.showError(message: Localizable.getString(key: "signup_error_cardid_not_exists"))
            } else if error == LoginCheck.ErrorType.passwordInvalid {
                self?.view?.showError(message: Localizable.getString(key: "signup_error_password_invalid"))
            } else {
                self?.view?.showError(message: Localizable.getString(key: "signup_error_connection_unknown"))
            }
        }
    }
    
}
