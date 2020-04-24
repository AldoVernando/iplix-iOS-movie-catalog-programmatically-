//
//  RegisterView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Iplix"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let username: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.tag = 0
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let dob: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of Birth"
        textField.tag = 1
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let email: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.tag = 2
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let password: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.tag = 3
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
          
        return textField
    }()
    
    let confirmationPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirmation Password"
        textField.tag = 4
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubviews()
    }
    
    func createSubviews() {
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(username)
        addSubview(dob)
        addSubview(email)
        addSubview(password)
        addSubview(confirmationPassword)
        addSubview(registerBtn)
        
        NSLayoutConstraint.activate([
        
            // title label constraints
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // username textfield constraints
            username.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            username.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            username.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // dob textfield constraints
            dob.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 5),
            dob.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dob.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // email textfield constraints
            email.topAnchor.constraint(equalTo: dob.bottomAnchor, constant: 5),
            email.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            email.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // password textfield constraints
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5),
            password.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            password.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // confirmation password textfield constraints
            confirmationPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 5),
            confirmationPassword.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            confirmationPassword.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // register button constraints
            registerBtn.topAnchor.constraint(equalTo: confirmationPassword.bottomAnchor, constant: 10),
            registerBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            registerBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }

}
