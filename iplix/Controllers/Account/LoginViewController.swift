//
//  LoginViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    @IBAction func loginBtn(_ sender: UIButton) {
        let pass = passwordText.text
        
        print(pass as Any)
    }
    
}


// MARK: Functions
extension LoginViewController {
    
    
    // set up object in view controller
    func setUp() {
        loginBtn.layer.cornerRadius = 10
        hideKeyboardWhenTappedAround()
    }
    
    
    // dismiss keyboard when tapped out of keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    
    // dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
