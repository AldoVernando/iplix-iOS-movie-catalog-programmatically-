//
//  ProfileViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    
    let firebase = FirebaseManager()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerBtn.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
    }
    
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "userId")
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: Functions
extension ProfileViewController {
    
    
    // get user data
    func getUserData() {
        
        if let userId = UserDefaults.standard.string(forKey: "userId") {
          
            firebase.getUser(userId: userId)
            
            firebase.publishUser.subscribe(
                onNext: { response in
                    self.setProfile(user: response)
            }
            ).disposed(by: bag)
            
        }
    }
    
    
    // set profile data
    func setProfile(user: User) {
        
        username.text = user.username
        email.text = user.email
        dob.text = user.dob
        
    }
    
}
