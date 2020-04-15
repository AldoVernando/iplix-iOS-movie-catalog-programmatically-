//
//  AccountAuthViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountAuthViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       showLogin()
    }

    @IBAction func indexSegmentChange(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        
            case 0:
                let vc = showViewController(controller: "LoginViewController") as! LoginViewController
                
                self.addChild(vc)
                self.contentView.addSubview(vc.view)
                break
            
            case 1:
                let vc = showViewController(controller: "RegisterViewController") as! RegisterViewController
                
                self.addChild(vc)
                self.contentView.addSubview(vc.view)
                break
            
            default:
                break
        }
        
    }
}


// MARK: Functions
extension AccountAuthViewController {
    
    
     // show selected view controller
    func showViewController(controller: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: controller)
        
        return viewController
    }
    
    
    // show login view
    func showLogin() {
        
        segmentedControl.selectedSegmentIndex = 0
        let vc = showViewController(controller: "LoginViewController") as! LoginViewController

        self.addChild(vc)
        self.contentView.addSubview(vc.view)
    }
    
    
    // show profile view
    func showProfile() {
        
        let accountView = parent as! AccountViewController
        accountView.showProfile()
        
    }
    
}
