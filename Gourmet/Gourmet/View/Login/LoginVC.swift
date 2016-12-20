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
        
        let startIndex = account.cardId.startIndex
        let endIndex = account.cardId.index(account.cardId.endIndex, offsetBy: -4)
        let replaceString = "**** **** **** "
        let range = startIndex ..< endIndex
        cardIdL.text = account.cardId.replacingCharacters(in: range, with: replaceString)
    }
    
    func showError(message: String) {
        let titleMessage = Localizable.getString(key: "login_alert_title")
        let okMessage = Localizable.getString(key: "login_alert_ok")
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: okMessage, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func actionLogin (_ sender : UIButton) {
        presenter.login(account: account)
    }
    
    @IBAction func actionUnlinkCard (_ sender : UIButton) {
        presenter.unlink(account: account)
    }
}
