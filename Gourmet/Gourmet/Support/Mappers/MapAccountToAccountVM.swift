//
//  MapAccountToAccountVM.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation
import GourmetModel

class MapAccountToAccountVM : NSObject {
    
    func map(source: Account) -> AccountVM {
        let account = AccountVM()
        account.cardId = source.cardId
        account.password = source.password
        return account

    }
    
}
