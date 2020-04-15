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
        let pass = passwordText.text?.sha256()
     
        firebase.checkLogin(email: email!, password: pass!)
        
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
    
    
    // set up object in view controller
    func setUp() {
        loginBtn.layer.cornerRadius = 10
        setDelegate()
        subscribeToFirebaseUser()
        hideKeyboardWhenTappedAround()
    }
    
    
    // set delegate to all text field
    func setDelegate() {
        emailText.delegate = self
        passwordText.delegate = self
    }
    
    
    // subscribe to check login firebase user
    func subscribeToFirebaseUser() {
        firebase.publishUserId.subscribe(
            onNext: { response in
                self.validateLogin(userId: response)
            }
        ).disposed(by: bag)
    }
    
    
    // validate login
    func validateLogin(userId: String) {
        if userId == "invalid" {
            showAlert(message: "Invalid email or password")
        } else {
            UserDefaults.standard.set(userId, forKey: "userId")
            
            let accountView = parent as! AccountAuthViewController
            accountView.showProfile()
        }
    }
    
    
    // show alert
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Information", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
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
