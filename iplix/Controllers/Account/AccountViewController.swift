//
//  AccountViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

//    @IBOutlet weak var accountView: UIView!
    
    private let accountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtn(_:)) )
        
        navigationItem.leftBarButtonItem = backBtn
        
        view.backgroundColor = .white
        
        view.addSubview(accountView)
        
        NSLayoutConstraint.activate([
        
            // account view constraints
            accountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountView.leftAnchor.constraint(equalTo: view.leftAnchor),
            accountView.rightAnchor.constraint(equalTo: view.rightAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        checkLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @objc func backBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: Functions
extension AccountViewController {
    
    
    // check user login session
    func checkLogin() {
        
        if UserDefaults.standard.string(forKey: "userId") == nil {
            let vc = AccountAuthViewController()
            navigationItem.title = "Account"
            self.addChild(vc)
            self.changeContentView(view: vc.view)
        } else {
            let vc = ProfileViewController()
            navigationItem.title = "Profile"
            self.addChild(vc)
            self.changeContentView(view: vc.view)
        }
        
    }
    
    
    // show profile view
    func showProfile() {
        
        let vc = ProfileViewController()
        navigationItem.title = "Profile"
        
        self.addChild(vc)
        self.changeContentView(view: vc.view)
    }
    
    
    // show selected view controller
    func showViewController(controller: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: controller)
        
        return viewController
    }
    
    
    // change content view
    func changeContentView(view: UIView) {
        
        UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve,
        animations: {
            self.accountView.addSubview(view)
        }, completion: nil)
    }
}
