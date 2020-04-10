//
//  PersonTableViewCell.swift
//  iplix
//
//  Created by TEMP on 4/10/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var network = ViewController.network
    var persons: [Person] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "personCell")
        
        loadPersons()
    }

}


// MARK: UICollectionView
extension PersonTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCollectionViewCell
            
        cell.name.text = persons[indexPath.row].name!
        if let pic = persons[indexPath.row].profile_path {
            cell.profilePicture.sd_setImage(with: URL(string: network.posterURL + pic))
        }
        
        return cell
    }
    
}


// MARK: Functions
extension PersonTableViewCell {
    
    
    // load person list
    func loadPersons() {
        network.getPersons { response in
            self.persons = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
