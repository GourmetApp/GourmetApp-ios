//
//  SignUpPresenter.swift
//  Gourmet
//
//  Created by David Martinez on 09/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class SignUpPresenter : NSObject {
    
    private var loginChecker : LoginCheck!
    
    init(loginCheckInteractor : LoginCheck) {
        loginChecker = loginCheckInteractor
    }
    
    func signUp (cardId : String?, password : String?, view : SignUpView) {
        guard cardId != nil && cardId!.characters.count != 0 else {
            view.showError(message: Localizable.getString(key: "signup_error_cardid_empty"))
            return
        }
        
//        let cardIdParsed = String (describing:
//            cardId?.characters.filter({ (c : Character) -> Bool in
//                return String(c).rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
//            })
//        )
        
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
        
        view.showLoading()
        
        let account = Account(cardId: cardId!, password: password!)
        loginChecker.execute(account: account) { (account : Account, error : LoginCheck.ErrorType) in
            if error == LoginCheck.ErrorType.noError {
                // TODO: Navegar a visor
            } else if error == LoginCheck.ErrorType.cardIdNotExists {
                view.showError(message: Localizable.getString(key: "signup_error_cardid_not_exists"))
            } else if error == LoginCheck.ErrorType.passwordInvalid {
                view.showError(message: Localizable.getString(key: "signup_error_password_invalid"))
            } else {
                view.showError(message: Localizable.getString(key: "signup_error_connection_unknown"))
            }
        }
    }
    
}
