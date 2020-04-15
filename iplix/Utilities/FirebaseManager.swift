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
    func createUser(user: User) {
        
        let userRef = ref.child("users").child(user.id!)
        
        userRef.updateChildValues(user.getData())
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
                
            let user = User(id: userId, username: username, dob: dob, email: email, password: "")
            
            self.publishUser.onNext(user)
        })
    }
    
    
    // check login
    func checkLogin(email: String, password: String) {
        
        let userRef = self.ref.child("users")

        userRef.observeSingleEvent(of: .value) { snapshot in
            
            let enumerator = snapshot.children
                    
            DispatchQueue.main.async {
                var isUser = false
                
                while let child = enumerator.nextObject() as? DataSnapshot {
                    
                    let childSnapshot = snapshot.childSnapshot(forPath: child.key)
                    
                    guard let dict = childSnapshot.value as? [String: Any] else { continue }
                    
                    let checkEmail = dict["email"] as! String
                    let checkPass = dict["password"] as! String
                    
                    if email == checkEmail && password == checkPass {
                        
                        isUser = true
                        self.publishUserId.onNext(child.key)
                        
                        break
                    }
                    
                }
                if !isUser {
                    self.publishUserId.onNext("invalid")
                }
            }
        }
    }
    
}
