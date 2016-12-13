//
//  LoginFactory.swift
//  Gourmet
//
//  Created by David Martinez on 11/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginFactory: NSObject {

    private static let instance = LoginFactory()
    
    open class var shared : LoginFactory {
        get {
            return LoginFactory.instance
        }
    }
    
    func getPresenter() -> LoginPresenter {
        let getStorage = GetStoredAccount()
        let postStorage = StoreAccount()
        let mapper = MapAccountToAccountVM()
        
        let service = GourmetServiceDM()
        let parser = LoginCheckParser()
        let storage = StoreAccount()
        let loginChecker = LoginCheck(dm: service, parser: parser, storage: storage)
        
        return LoginPresenter(interactorGet: getStorage,
                              interactorPost: postStorage,
                              interactorLogin: loginChecker,
                              mapper: mapper)
    }
    
}
