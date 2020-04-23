//
//  AccountAuthViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountAuthViewController: UIViewController {

    private let segmentedControl: UISegmentedControl = {
        let items = ["Login", "Register"]
        let segment = UISegmentedControl(items: items)
        segment.addTarget(self, action: #selector(indexSegmentChange(_:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        return segment
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        
//        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
        
            // segemented control constraints
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // content view constraints
//            contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
//            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
//        print(segmentedControl.frame.width)
//        showLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
