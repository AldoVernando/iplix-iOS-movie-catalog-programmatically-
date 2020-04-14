//
//  User.swift
//  iplix
//
//  Created by TEMP on 4/14/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import CryptoSwift

class User {
    var id:String?
    var username: String?
    var dob: String?
    var email: String?
    var password: String?
    
    init(id: String, username: String, dob: String, email: String, password: String) {
        self.id = id
        self.username = username
        self.dob = dob
        self.email = email
        self.password = password.sha256()
    }
    
    
    // generate dictionary
    func getData() -> [String: Any]{
        
        var dict = [String: Any]()
        
        dict.updateValue(self.id!, forKey: "id")
        dict.updateValue(self.username!, forKey: "username")
        dict.updateValue(self.dob!, forKey: "dob")
        dict.updateValue(self.email!, forKey: "email")
        dict.updateValue(self.password!, forKey: "password")
        
        return dict
    }
}
