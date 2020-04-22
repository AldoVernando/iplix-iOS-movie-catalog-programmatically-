//
//  LoginViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import CryptoSwift
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let firebase = FirebaseManager()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    @IBAction func loginBtn(_ sender: UIButton) {
        
        let email = emailText.text
        let pass = passwordText.text
     
        firebase.checkLogin(email: email!, password: pass!, vc: self)
    }
    
}


// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}


// MARK: Functions
extension LoginViewController {
    
    
    // set up view controller
    func setUp() {
        loginBtn.layer.cornerRadius = 10
        setDelegate()
        hideKeyboardWhenTappedAround()
    }
    
    
    // set delegate to all text field
    func setDelegate() {
        emailText.delegate = self
        passwordText.delegate = self
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
