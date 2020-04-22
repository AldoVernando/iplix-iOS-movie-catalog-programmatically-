//
//  FirebaseManager.swift
//  iplix
//
//  Created by TEMP on 4/14/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class FirebaseManager {
    
    let ref = Database.database().reference()
    let dispatchQueue = DispatchQueue(label: "FIREBASE_REQUEST")
    let dispatchGroup  = DispatchGroup()
    var publishUserId = PublishSubject<String>()
    var publishUser = PublishSubject<User>()
}


// MARK: Functions
extension FirebaseManager {
    
    
    // create user
    func createUser(user: User, vc: UIViewController) {
        
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { authResult, error in
            
            if let err = error {
                Helper.showAlert(message: err.localizedDescription, vc: vc)
            } else {
                let ref = Database.database().reference()
                ref.child("users").child((authResult?.user.uid)!).setValue(user.getData())
                
                Helper.showAlert(message: "Register success", vc: vc)
                
                let parent = vc.parent as! AccountAuthViewController
                parent.showLogin()
            }
        }
    }
    
    
    // get user
    func getUser(userId: String) {
        
        let userRef = ref.child("users").child(userId)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! NSDictionary
            let username = value["username"] as! String
            let email = value["email"] as! String
            let dob = value["dob"] as! String
                
            let user = User(username: username, dob: dob, email: email, password: "")
            
            self.publishUser.onNext(user)
        })
    }
    
    
    // check login
    func checkLogin(email: String, password: String, vc: UIViewController) {
        
       Auth.auth().signIn(withEmail: email, password: password) { authResult,
        error in
            if let err = error {
                Helper.showAlert(message: err.localizedDescription, vc: vc)
            } else {
                UserDefaults.standard.set(authResult?.user.uid, forKey: "userId")
                
                Helper.showAlert(message: "Login success", vc: vc)
                
                let accountView = vc.parent as! AccountAuthViewController
                accountView.showProfile()
            }
       }
    }
    
}
