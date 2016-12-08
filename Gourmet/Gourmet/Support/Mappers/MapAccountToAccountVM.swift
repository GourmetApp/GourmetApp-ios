//
//  MapAccountToAccountVM.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

class MapAccountToAccountVM : NSObject, MappeableProtocol {
    
    typealias SOURCE = Account
    typealias RESULT = AccountVM
    
    func map(source: Account) -> AccountVM? {
        let account = AccountVM()
        account.cardId = source.cardId
        account.password = source.password
        return account

    }
    
}
