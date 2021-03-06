//
//  LoginVC.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit
import GourmetModel

class MainVC : UIViewController, MainView {
    
    private var signUpVC : SignUpVC?
    private var loginVC : LoginVC?
    private var currentVC : UIViewController?
    private var presenter : MainPresenter!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = MainFactory.default.getMainPresenter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = MainFactory.default.getMainPresenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.updateView(view: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentVC?.resignFirstResponder()
    }
    
    private func localize () {
        self.title = Localizable.getString(key: "login_window_title")
    }
    
    func showAccountInfo(account: AccountVM) {
        if (isMountedViewController(vc: loginVC)) {
            return
        }
        
        if (currentVC != nil) {
            remove(viewController: currentVC!)
        }
        
        if (loginVC == nil) {
            loginVC = MainFactory.default.getLoginVC()
        }
        
        currentVC = loginVC
        add(viewController: loginVC!)
        
        animateAppear(childVC: loginVC!)
    }
    
    func showNoAccount() {
        if (isMountedViewController(vc: signUpVC)) {
            return
        }
        
        if (currentVC != nil) {
            remove(viewController: currentVC!)
        }
        
        if (signUpVC == nil) {
            signUpVC = MainFactory.default.getSignUpView()
        }
        
        currentVC = signUpVC
        add(viewController: signUpVC!)
        
        animateAppear(childVC: signUpVC!)
    }
    
    private func animateAppear (childVC : UIViewController) {
        childVC.view.alpha = 0.0
        childVC.view.frame.origin.y = 30.0
        
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: 0.3, timingParameters: timing)
        animator.addAnimations {
            childVC.view.frame.origin.y = 0.0
            childVC.view.alpha = 1.0
        }
        
        animator.startAnimation()
    }
    
    private func isMountedViewController (vc : UIViewController?) -> Bool {
        return vc?.parent != nil
    }
    
    func navigateBalance(account : Account) {
        performSegue(withIdentifier: "main_to_balance", sender: account)
    }
    
    private func add (viewController : UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = view.frame
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove (viewController : UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    // MARK: Storyboard navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard sender is Account else { return }
        if let layout = segue.destination as? BalanceVC {
            layout.setAccount(account: sender as! Account)
        }
    }
}
