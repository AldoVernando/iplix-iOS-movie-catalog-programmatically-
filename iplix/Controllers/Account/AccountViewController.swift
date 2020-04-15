//
//  AccountViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var accountView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        checkLogin()
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: Functions
extension AccountViewController {
    
    
    // check user login session
    func checkLogin() {
        
        var vc: UIViewController = showViewController(controller: "ProfileViewController") as! ProfileViewController
        navigationItem.title = "Profile"
        
        if UserDefaults.standard.string(forKey: "userId") == nil {
            vc = showViewController(controller: "AccountAuthViewController") as! AccountAuthViewController
            navigationItem.title = "Account"
        }
        
        self.addChild(vc)
        self.accountView.addSubview(vc.view)
    }
    
    
    // show profile view
    func showProfile() {
        
        let vc = showViewController(controller: "ProfileViewController") as! ProfileViewController
        navigationItem.title = "Profile"
        
        self.addChild(vc)
        self.accountView.addSubview(vc.view)
    }
    
    
    // show selected view controller
    func showViewController(controller: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: controller)
        
        return viewController
    }
}
