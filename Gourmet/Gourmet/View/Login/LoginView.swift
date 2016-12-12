//
//  LoginView.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol LoginView : NSObjectProtocol {
    
    func showAccount(account : AccountVM)
    func showError(message : String)
    
}
