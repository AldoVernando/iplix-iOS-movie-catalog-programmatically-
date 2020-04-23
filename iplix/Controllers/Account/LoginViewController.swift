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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Iplix"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.tag = 0
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let passwordText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.tag = 1
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
          
        return textField
    }()
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let firebase = FirebaseManager()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(emailText)
        view.addSubview(passwordText)
        view.addSubview(loginBtn)
        
        
        NSLayoutConstraint.activate([
            
            // title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // email textfield constraints
            emailText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            emailText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            emailText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // password textfield constraints
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 5),
            passwordText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            passwordText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // login button constraints
            loginBtn.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 10),
            loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
        ])
        
        
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
