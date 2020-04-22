//
//  User.swift
//  iplix
//
//  Created by TEMP on 4/14/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

class User {

    var username: String?
    var dob: String?
    var email: String?
    var password: String?
    
    init(username: String, dob: String, email: String, password: String) {
        self.username = username
        self.dob = dob
        self.email = email
        self.password = password
    }
    
    
    // generate dictionary
    func getData() -> [String: Any]{
        
        var dict = [String: Any]()
        
        dict.updateValue(self.username!, forKey: "username")
        dict.updateValue(self.dob!, forKey: "dob")
        dict.updateValue(self.email!, forKey: "email")
        
        return dict
    }
}
