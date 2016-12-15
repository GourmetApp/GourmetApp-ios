//
//  BalancePresenter.swift
//  Gourmet
//
//  Created by David Martinez on 13/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class BalancePresenter : NSObject, GetBalanceListener {
    
    private weak var view : BalanceView?
    private var getBalance : GetBalance!
    private var balanceToVMMapper : MapBalanceToBalanceVM!
    
    init(getBalance : GetBalance,
         balanceToVMMapper : MapBalanceToBalanceVM) {
        super.init()
        
        self.balanceToVMMapper = balanceToVMMapper
        self.getBalance = getBalance
        self.getBalance.setListener(listener: self)
    }
    
    func bind(view : BalanceView) {
        self.view = view
    }
    
    func updateView (account : Account) {
        view?.showLoading()
        getBalance.execute(account: account)
    }
    
    // MARK: GetBalanceListener
    func onSuccess(balance: Balance) {
        let balanceVM = balanceToVMMapper.map(source: balance)!
        view?.showBalance(balance: balanceVM)
    }
    
    func onError() {
        let message = Localizable.getString(key: "balance_error_message")
        view?.showError(message: message)
    }
}
