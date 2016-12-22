//
//  TodayViewController.swift
//  GourmetToday
//
//  Created by David Martinez on 21/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit
import NotificationCenter
import GourmetModel

class TodayViewController: UIViewController, NCWidgetProviding,
GetBalanceOnlineListener, GetStoredAccountListener {
    
    @IBOutlet weak var loadingView : UIView!
    @IBOutlet weak var errorLabel : UILabel!
    @IBOutlet weak var balanceView : UIView!
    @IBOutlet weak var balanceLabel : UILabel!
    
    private var lastBalance : Balance?
    private var getAccount : GetStoredAccount!
    private var getBalance : GetBalanceOnline!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInteractors()
        decorView()
    }
    
    private func configureInteractors () {
        let balanceParser = BalanceParser()
        let service = GourmetServiceDM()
        getBalance = GetBalanceOnline(parseBalance: balanceParser, dm: service)
        getBalance.setListener(listener: self)
        
        getAccount = GetStoredAccount()
        getAccount.setListener(listener: self)
    }
    
    private func decorView () {
        self.title = Localizable.getString(key: "widget_title")
        extensionContext?.widgetLargestAvailableDisplayMode = .compact
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        showLoading()
        getAccount.execute()
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func showLoading () {
        balanceView.isHidden = true
        loadingView.isHidden = false
        errorLabel.isHidden = true
    }
    
    // MARK: GetStoredAccount
    func onFinish(interactor: GetStoredAccount, account: Account?) {
        if account != nil {
            getBalance.execute(account: account!)
        } else {
            let message = Localizable.getString(key: "widget_no_account")
            showError(message: message)
        }
    }
    
    // MARK: GetBalanceListener
    func onFinish(getBalanceOnline: GetBalanceOnline, balance: Balance?) {
        if balance != nil {
            lastBalance = balance
            showBalance(balance: balance!)
        } else if (lastBalance == nil) {
            let message = Localizable.getString(key: "widget_load_error")
            showError(message: message)
        }
        
        // do nothing
    }
    
    private func showError (message : String) {
        balanceView.isHidden = true
        loadingView.isHidden = true
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    private func showBalance (balance : Balance) {
        balanceView.isHidden = false
        loadingView.isHidden = true
        errorLabel.isHidden = true
        balanceLabel.text = balance.quantity
    }
}
