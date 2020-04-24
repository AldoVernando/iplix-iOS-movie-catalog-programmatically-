//
//  LoginView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class LoginView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Iplix"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let emailText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.tag = 0
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let passwordText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.tag = 1
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
          
        return textField
    }()
    
    let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
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
        addSubview(emailText)
        addSubview(passwordText)
        addSubview(loginBtn)
        
        
        NSLayoutConstraint.activate([
            
            // title label constraints
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // email textfield constraints
            emailText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            emailText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            emailText.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // password textfield constraints
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 5),
            passwordText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            passwordText.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // login button constraints
            loginBtn.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 10),
            loginBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            loginBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
        ])
    }

}
