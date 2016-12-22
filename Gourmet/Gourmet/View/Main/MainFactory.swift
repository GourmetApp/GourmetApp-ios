//
//  LoginFactory.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation
import GourmetModel

class MainFactory : NSObject {
    
    private static let factory = MainFactory()
    
    override private init() {
        super.init()
    }
    
    open class var `default`: MainFactory {
        get {
            return factory
        }
    }
    
    func getLoginVC () -> LoginVC {
        return LoginVC(nibName: "LoginVC", bundle: nil)
    }
    
    func getSignUpView () -> SignUpVC {
        return SignUpVC(nibName: "SignUpVC", bundle: nil)
    }
    
    func getMainPresenter () -> MainPresenter {
        let storedInteractor = GetStoredAccount()
        let accountObserver = StoreAccountObserver()
        let mapper = MapAccountToAccountVM()
        let presenter = MainPresenter(getAccount: storedInteractor,
                                      accountObserver: accountObserver,
                                      mapper: mapper)
        return presenter
    }
}
