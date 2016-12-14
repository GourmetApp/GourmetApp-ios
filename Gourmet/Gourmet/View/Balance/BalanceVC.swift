//
//  BalanceVC.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class BalanceVC : UIViewController, BalanceView, UITableViewDelegate, UITableViewDataSource {
    
    private var presenter : BalancePresenter!
    private var account : Account!
    private var balance : BalanceVM?
    
    @IBOutlet weak var eurosLabel : UILabel!
    @IBOutlet weak var centsLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    
    func setAccount (account : Account) {
        self.account = account
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = BalanceFactory.shared.getPresenter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = BalanceFactory.shared.getPresenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.bind(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.updateView(account: account)
        
//        let balance = BalanceVM()
//        balance.quantity = "127.34"
//        balance.lastPurchases = []
//        
//        for _ in 0 ..< 3 {
//            let purchase = PurchaseVM()
//            purchase.quantity = "10.0"
//            purchase.commerce = "Comercio"
//            purchase.location = "Madrid"
//            purchase.type = .spend
//            purchase.date = Date()
//            balance.lastPurchases.append(purchase)
//        }
//        
//        showBalance(balance: balance)
    }
    
    // MARK: BalanceView
    func showBalance(balance: BalanceVM) {
        self.balance = balance
        
        let balanceComponents = balance.quantity.components(separatedBy: ".")
        let euros = balanceComponents.first ?? "0"
        let cents = balanceComponents.last ?? "00"
        eurosLabel.text = euros
        centsLabel.text = ",\(cents)"
        
        tableView.reloadData()
    }
    
    func showError(message: String) {
        // TODO:
    }
    
    // MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balance?.lastPurchases.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BalanceViewCell
        
        if let purchase = balance?.lastPurchases[indexPath.row] {
            cell?.show(purchase: purchase)
        }
        
        return cell!
    }
    
}

class BalanceViewCell : UITableViewCell {
    
    @IBOutlet weak var commerceLabel : UILabel!
    @IBOutlet weak var priceDateLabel : UILabel!
    
    func show(purchase : PurchaseVM) {
        commerceLabel.text = "\(purchase.commerce)(\(purchase.location))"
        priceDateLabel.text = "\(purchase.quantity) (\(purchase.date))"
    }
    
    override func prepareForReuse() {
        commerceLabel.text = nil
        priceDateLabel.text = nil
    }
}
