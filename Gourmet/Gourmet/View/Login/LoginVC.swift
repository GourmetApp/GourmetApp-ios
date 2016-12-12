//
//  LoginVC.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, LoginView {

    @IBOutlet weak var cardIdL : UILabel!
    @IBOutlet weak var loginButton : UIButton!
    
    private var account : AccountVM!
    private var presenter : LoginPresenter!
    
    // MARK: Lifecicle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = LoginFactory.shared.getPresenter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = LoginFactory.shared.getPresenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.bind(view: self)
    }
    
    private func decorViews () {
        loginButton.layer.cornerRadius = 6.0
        loginButton.clipsToBounds = true
    }

    // MARK: LoginView
    func showAccount(account: AccountVM) {
        self.account = account
        cardIdL.text = account.cardId
        
        // TODO: Replace first chars of cardId with ****
    }
    
    func showError(message: String) {
        // TODO:
    }
    
    // MARK: Actions
    @IBAction func actionLogin (_ sender : UIButton) {
        // TODO:
    }
    
    @IBAction func actionUnlinkCard (_ sender : UIButton) {
        presenter.unlink(account: account)
    }
}
