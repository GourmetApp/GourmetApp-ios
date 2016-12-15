//
//  BalanceView.swift
//  Gourmet
//
//  Created by David Martinez on 13/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol BalanceView : NSObjectProtocol {
    
    func showLoading ()
    func showBalance (balance : BalanceVM)
    func showError (message : String)
    
}
