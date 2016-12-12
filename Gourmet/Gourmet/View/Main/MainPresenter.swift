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

class MainPresenter : NSObject, MainPresenterInterface, GetStoredAccountListener,
StoreAccountObserverListener {
    
    private var getAccountInteractor : GetStoredAccount!
    private var accountObserverInteractor : StoreAccountObserver!
    private var mapper : MapAccountToAccountVM!
    
    private weak var view : MainView?
    
    init(getAccount : GetStoredAccount,
         accountObserver : StoreAccountObserver,
         mapper : MapAccountToAccountVM) {
        
        super.init()
        
        getAccountInteractor = getAccount
        getAccountInteractor.setListener(listener: self)
        
        accountObserverInteractor = accountObserver
        accountObserverInteractor.setListener(listener: self)
        accountObserverInteractor.execute()
        
        self.mapper = mapper
    }
    
    deinit {
        accountObserverInteractor.setListener(listener: nil)
    }
    
    func updateView(view: MainView) {
        self.view = view
        getAccountInteractor.execute()
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
    
    // MARK: StoreAccountObserverListener
    func onChange(observer: StoreAccountObserver, account: Account?) {
        if (account == nil) {
            view?.showNoAccount()
        } else {
            let accountVM = self.mapper.map(source: account!)!
            view?.showAccountInfo(account: accountVM)
        }
    }
}
