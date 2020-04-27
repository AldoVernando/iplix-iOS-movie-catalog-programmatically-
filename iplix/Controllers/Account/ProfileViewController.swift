//
//  ProfileViewController.swift
//  iplix
//
//  Created by TEMP on 4/13/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import Firebase

class ProfileViewController: UIViewController, UINavigationControllerDelegate {

    let customView = ProfileView()
    var profileImage: UIImageView!
    var username: UILabel!
    var emailLabel: UILabel!
    var email: UILabel!
    var dobLabel: UILabel!
    var dob: UILabel!
    var logoutBtn: UIButton!
    
    let firebase = FirebaseManager()
    let bag = DisposeBag()
    let imagePicker = UIImagePickerController()
    
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
        logoutBtn = customView.logoutBtn
        
        
        let imageRef = firebase.getStorageRef()
        imageRef.downloadURL(completion: { (url, error) in
            self.profileImage.sd_setImage(with: url!, placeholderImage: UIImage(named: "profile"))
        })
        
        imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editProfileImage(_:)) )
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
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
    
    @objc func editProfileImage(_ tapGestureRecognizer: UITapGestureRecognizer) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.contentMode = .scaleToFill
            profileImage.image = pickedImage
            
            firebase.uploadPhoto(image: pickedImage)
        
            dismiss(animated: true, completion: nil)
        }
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
