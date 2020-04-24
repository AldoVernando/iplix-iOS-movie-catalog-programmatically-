//
//  PersonDetailViewController.swift
//  iplix
//
//  Created by TEMP on 4/10/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    let customView = PersonDetailView()
    var scroller: UIScrollView!
    var content: UIView!
    var name: UILabel!
    var birthday: UILabel!
    var placebirth: UILabel!
    var biography: UILabel!
    
    var network = ViewController.network
    var personId: Int?
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scroller = customView.scroller
        content = customView.content
        name = customView.name
        birthday = customView.birthday
        placebirth = customView.placebirth
        biography = customView.biography
        
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtn(_:)) )
        
        navigationItem.leftBarButtonItem = backBtn
        
        loadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        scroller.contentSize = CGSize(width: UIScreen.main.bounds.width, height: content.frame.height + 50)
    }
    
    @objc func backBtn(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }

}


// MARK: Functions
extension PersonDetailViewController {
    
    
    // load person detail
    func loadData() {
        if let id = personId {
            network.getPersonDetail(id: id) { response in
                self.name.text = response.name
                self.birthday.text = response.birthday
                self.placebirth.text = response.place_of_birth
                self.biography.text = response.biography
            }
        }
    }
}
