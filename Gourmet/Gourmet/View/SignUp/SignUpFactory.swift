//
//  SignUpFactory.swift
//  Gourmet
//
//  Created by David Martinez on 10/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class SignUpFactory : NSObject {

    private static let instance = SignUpFactory()
    
    open class var shared : SignUpFactory {
        get {
            return SignUpFactory.instance
        }
    }
    
    func getPresenter () -> SignUpPresenter {
        let loginChecker = LoginCheck()
        return SignUpPresenter(loginCheckInteractor: loginChecker)
    }
    
}
