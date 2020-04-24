//
//  AccountAuthViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountAuthViewController: UIViewController {
    
    let customView = AccountAuthView()
    var segmentedControl: UISegmentedControl!
    var contentView: UIView!
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl = customView.segmentedControl
        contentView = customView.contentView
        
        segmentedControl.addTarget(self, action: #selector(indexSegmentChange(_:)), for: .valueChanged)
        
        showLogin()
    }
    
    override func viewDidLayoutSubviews() {
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    @objc func indexSegmentChange(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        
            case 0:
                let vc = LoginViewController()
                
                self.addChild(vc)
                self.changeContentView(view: vc.view)
                break
            
            case 1:
                let vc = RegisterViewController()
                
                self.addChild(vc)
                self.changeContentView(view: vc.view)
                break
            
            default:
                break
        }
        
    }
}


// MARK: Functions
extension AccountAuthViewController {

    
    // show login view
    func showLogin() {
        
        segmentedControl.selectedSegmentIndex = 0
        let vc = LoginViewController()

        self.addChild(vc)
        self.changeContentView(view: vc.view)
    }
    
    
    // show profile view
    func showProfile() {
        
        let accountView = parent as! AccountViewController
        accountView.showProfile()
    }
    
    
    // change content view
    func changeContentView(view: UIView) {
        
        UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve,
        animations: {
            self.contentView.addSubview(view)
        }, completion: nil)
    }
    
}
