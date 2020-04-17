//
//  PersonDetailViewController.swift
//  iplix
//
//  Created by TEMP on 4/10/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var placebirth: UILabel!
    @IBOutlet weak var biography: UILabel!
    
    var network = ViewController.network
    var personId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
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
