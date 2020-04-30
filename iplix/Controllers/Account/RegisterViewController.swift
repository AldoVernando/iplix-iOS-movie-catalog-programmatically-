//
//  RegisterViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let customView = RegisterView()
    var titleLabel: UILabel!
    var username: UITextField!
    var dob: UITextField!
    var email: UITextField!
    var password: UITextField!
    var confirmationPassword: UITextField!
    var registerBtn: UIButton!
    
    let datePicker = UIDatePicker()
    let firebase = FirebaseManager()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username = customView.username
        dob = customView.dob
        email = customView.email
        password = customView.password
        confirmationPassword = customView.confirmationPassword
        registerBtn = customView.registerBtn
        
        registerBtn.addTarget(self, action: #selector(registerBtn(_:)), for: .touchUpInside)
        
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    @objc func registerBtn(_ sender: UIButton) {
        
        let usernameText = username.text
        let dobText = dob.text
        let emailText = email.text
        let passText = password.text
        
        if validate() {
            
            let user = User(username: usernameText!, dob: dobText!, email: emailText!, password: passText!)
            firebase.createUser(user: user, vc: self)
            
        }
    }
    
}


// MARK: UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    
    
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
extension RegisterViewController {
    
    
    // set up view controller
    func setUp() {
        setDelegate()
        showDatePicker()
        hideKeyboardWhenTappedAround()
    }
    
    
    // set delegate to all text field
    func setDelegate() {
        username.delegate = self
        dob.delegate = self
        email.delegate = self
        password.delegate = self
        confirmationPassword.delegate = self
    }
    
    
    // validate input
    func validate() -> Bool {
        
        if username.text!.isEmpty || dob.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty || confirmationPassword.text!.isEmpty {
            Helper.showAlert(message: "All data must be filled", vc: self)
            return false
        }
        else if password.text != confirmationPassword.text {
            Helper.showAlert(message: "Confirmation password not same with password", vc: self)
            return false
        }
        
        return true
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
    
    
    // show date picker when dob textfield clicked
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date

       //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        dob.inputAccessoryView = toolbar
        dob.inputView = datePicker

    }

    
    // when done button clicked
    @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       dob.text = formatter.string(from: datePicker.date)
       view.endEditing(true)
    }

    
    // when cancel button clicked
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    
}
