//
//  LoginView.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol MainView : NSObjectProtocol {
    
    func showAccountInfo(account : AccountVM)
    func showNoAccount()
    
}
