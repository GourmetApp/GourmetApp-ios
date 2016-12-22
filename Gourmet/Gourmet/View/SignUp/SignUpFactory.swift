//
//  SignUpFactory.swift
//  Gourmet
//
//  Created by David Martinez on 10/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation
import GourmetModel

class SignUpFactory : NSObject {

    private static let instance = SignUpFactory()
    
    open class var shared : SignUpFactory {
        get {
            return SignUpFactory.instance
        }
    }
    
    func getPresenter () -> SignUpPresenter {
        let accountMapper = MapAccountToAccountVM()
        let service = GourmetServiceDM()
        let parser = LoginCheckParser()
        let storage = StoreAccount()
        let loginChecker = LoginCheck(dm: service, parser: parser, storage: storage)
        return SignUpPresenter(loginCheckInteractor: loginChecker, mapper: accountMapper)
    }
    
}
