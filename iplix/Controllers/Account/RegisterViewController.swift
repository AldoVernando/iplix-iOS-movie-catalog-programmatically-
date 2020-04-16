//
//  RegisterViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmationPassword: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    let datePicker = UIDatePicker()
    let firebase = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    @IBAction func registerBtn(_ sender: UIButton) {
        
        let id = UUID()
        let usernameText = username.text
        let dobText = dob.text
        let emailText = email.text
        let passText = password.text
        
        if validate() {
        
            let user = User(id: id.uuidString, username: usernameText!, dob: dobText!, email: emailText!, password: passText!)
            firebase.createUser(user: user)
            
            let parent = self.parent as! AccountAuthViewController
            parent.showLogin()
            
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
        registerBtn.layer.cornerRadius = 10
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
            showAlert(message: "All data must be filled")
            return false
        }
        else if password.text != confirmationPassword.text {
            showAlert(message: "Confirmation password not same with password")
            return false
        }
        
        return true
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
       self.view.endEditing(true)
    }

    
    // when cancel button clicked
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
}
