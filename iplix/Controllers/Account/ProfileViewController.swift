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

    let customView = ProfileView()
    var profileImage: UIImageView!
    var username: UILabel!
    var emailLabel: UILabel!
    var email: UILabel!
    var dobLabel: UILabel!
    var dob: UILabel!
    var editBtn: UIButton!
    var logoutBtn: UIButton!
    
    let firebase = FirebaseManager()
    let bag = DisposeBag()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileImage = customView.profileImage
        username = customView.username
        emailLabel = customView.emailLabel
        email = customView.email
        dobLabel = customView.dobLabel
        dob = customView.dob
        editBtn = customView.editBtn
        logoutBtn = customView.logoutBtn
        
        editBtn.addTarget(self, action: #selector(editProfileBtn(_:)), for: .touchUpInside)
        logoutBtn.addTarget(self, action: #selector(logoutBtn(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
    }
    
    
    @objc func logoutBtn(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "userId")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editProfileBtn(_ sender: UIButton) {
        print("Edit button pressed")
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
