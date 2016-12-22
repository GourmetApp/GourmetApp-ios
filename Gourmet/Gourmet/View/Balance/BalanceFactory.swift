//
//  BalanceFactory.swift
//  Gourmet
//
//  Created by David Martinez on 14/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit
import GourmetModel

class BalanceFactory: NSObject {

    private static let instance = BalanceFactory()
    
    open class var shared : BalanceFactory {
        get {
            return BalanceFactory.instance
        }
    }
    
    func getPresenter () -> BalancePresenter {
        let interactor = getBalance()
        let mapper = MapBalanceToBalanceVM()
        let presenter = BalancePresenter(getBalance: interactor, balanceToVMMapper: mapper)
        return presenter
    }
    
    private func getBalance() -> GetBalance {
        let balanceOffline = getBalanceOffline()
        let balanceOnline = getBalanceOnline()
        let storeBalance = getStoreBalance()
        let getBalance = GetBalance(getBalanceOffline: balanceOffline,
                                    getBalanceOnline: balanceOnline,
                                    storeBalance: storeBalance)
        return getBalance
    }
    
    private func getBalanceOffline () -> GetBalanceOffline {
        return GetBalanceOffline()
    }
    
    private func getBalanceOnline () -> GetBalanceOnline {
        let parser = getBalanceParser()
        let dm = getDataManager()
        return GetBalanceOnline(parseBalance: parser, dm: dm)
    }
    
    private func getStoreBalance () -> StoreBalance {
        return StoreBalance()
    }
    
    private func getBalanceParser () -> BalanceParser {
        return BalanceParser()
    }
    
    private func getDataManager () -> GourmetServiceDM {
        return GourmetServiceDM()
    }
}
