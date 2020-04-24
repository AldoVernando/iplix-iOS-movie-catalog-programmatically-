//
//  ProfileView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        image.layer.borderWidth = 1
        image.image = UIImage(named: "profile")
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.text = "Aldo Vernando"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.text = "aldo.vernando@gmail.com"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dobLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of Birth"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dob: UILabel = {
        let label = UILabel()
        label.text = "02-03-2020"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let editBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let logoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
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
        
        addSubview(profileImage)
        addSubview(username)
        addSubview(emailLabel)
        addSubview(email)
        addSubview(dobLabel)
        addSubview(dob)
        addSubview(editBtn)
        addSubview(logoutBtn)
        
        NSLayoutConstraint.activate([
        
            // profile image constraints
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            
            // username constraints
            username.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            username.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            username.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // email label constraints
            emailLabel.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20),
            emailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            emailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:
            -16),
            
            // email constraints
            email.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            email.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            email.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // dob label constraints
            dobLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
            dobLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dobLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // dob constraints
            dob.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 10),
            dob.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dob.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // edit button constraints
            editBtn.topAnchor.constraint(equalTo: dob.bottomAnchor, constant: 100),
            editBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            editBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // logout button constraints
            logoutBtn.topAnchor.constraint(equalTo: editBtn.bottomAnchor, constant: 10),
            logoutBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            logoutBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
        ])
    }

}
