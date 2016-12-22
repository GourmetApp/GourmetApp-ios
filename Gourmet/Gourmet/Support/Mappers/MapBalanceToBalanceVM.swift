//
//  MapBalanceToBalanceVM.swift
//  Gourmet
//
//  Created by David Martinez on 14/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class MapBalanceToBalanceVM: NSObject {
    
    func map(source: Balance) -> BalanceVM? {
        
        let balanceVM = BalanceVM()
        balanceVM.quantity = source.quantity
        balanceVM.requestDate = source.requestDate
        balanceVM.lastPurchases = []
        for purchase in source.lastPurchases {
            let purchaseVM = PurchaseVM()
            purchaseVM.commerce = purchase.commerce
            purchaseVM.date = purchase.date
            purchaseVM.location = purchase.location
            purchaseVM.quantity = purchase.quantity
            purchaseVM.type = PurchaseVM.PurchaseType(rawValue: purchase.type.rawValue) ?? .spend
            balanceVM.lastPurchases.append(purchaseVM)
        }
        
        return balanceVM
    }
    
}
