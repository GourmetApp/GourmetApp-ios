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
    @IBOutlet weak var loadingView : UIActivityIndicatorView!
    
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
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(onPullToRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        cleanView()
        presenter.bind(view: self)
    }
    
    private func cleanView () {
        eurosLabel.text = nil
        centsLabel.text = nil
        dateLabel.text = nil
    }
    
    @objc private func onPullToRefresh(refreshControl: UIRefreshControl) {
        presenter.updateView(account: account)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.updateView(account: account)
    }
    
    // MARK: BalanceView
    func showBalance(balance: BalanceVM) {
        hideLoading()
        self.balance = balance
        
        let balanceComponents = balance.quantity.components(separatedBy: ".")
        let euros = balanceComponents.first ?? "0"
        let cents = balanceComponents.last ?? "00"
        eurosLabel.text = euros
        centsLabel.text = ",\(cents)"
        
        let dateMessageFormat = Localizable.getString(key: "balance_date_request_format")
        let dateFormat = "dd/MM/yyyy"
        let hourFormat = "HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateFormatted = dateFormatter.string(from: balance.requestDate)
        dateFormatter.dateFormat = hourFormat
        let hourFormatted = dateFormatter.string(from: balance.requestDate)
        let dateString = String(format: dateMessageFormat, dateFormatted, hourFormatted)
        dateLabel.text = dateString
        
        tableView.reloadData()
    }
    
    func showError(message: String) {
        hideLoading()
        
        let titleMessage = Localizable.getString(key: "balance_alert_title")
        let okMessage = Localizable.getString(key: "balance_alert_ok")
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: okMessage, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        if tableView.refreshControl?.isRefreshing == false {
            loadingView.isHidden = false
        }
    }
    
    private func hideLoading () {
        tableView.refreshControl?.endRefreshing()
        loadingView.isHidden = true
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
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var quantityLabel : UILabel!
    @IBOutlet weak var iconImageView : UIImageView!
    
    private static let increaseImage = UIImage(named: "increase")
    private static let decreaseImage = UIImage(named: "decrease")
    
    func show(purchase : PurchaseVM) {
        commerceLabel.text = purchase.commerce
        quantityLabel.text = purchase.quantity
        
        let dateFormat = "dd/MM/yyyy HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateLabel.text = dateFormatter.string(from: purchase.date)
        iconImageView.image = purchase.type == .spend ? BalanceViewCell.decreaseImage : BalanceViewCell.increaseImage
    }
    
    override func prepareForReuse() {
        commerceLabel.text = nil
        dateLabel.text = nil
        quantityLabel.text = nil
        iconImageView.image = nil
    }
}
