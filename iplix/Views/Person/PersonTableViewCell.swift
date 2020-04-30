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
    var delegate: PersonTableViewDelegate!
    var isWaiting = false
    var page = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "personCell")
        collectionView.register(UINib(nibName: "LoadingViewCell", bundle: nil), forCellWithReuseIdentifier: "loadingCell")
        
        loadPersons()
    }

}


// MARK: UICollectionView
extension PersonTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < persons.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCollectionViewCell
                
            cell.name.text = persons[indexPath.row].name!
            if let pic = persons[indexPath.row].profile_path {
                cell.profilePicture.sd_setImage(with: URL(string: network.posterURL + pic))
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! LoadingViewCell
            cell.loading.startAnimating()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row < persons.count {
            let person = persons[indexPath.row]
            delegate.goToPerson(id: person.id!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == persons.count && !isWaiting {
          isWaiting = true
          loadMoreData()
        }
    }
    
}


// MARK: Functions
extension PersonTableViewCell {
    
    
    // load person list
    func loadPersons() {
        network.getPersons(page: 1) { response in
            self.persons = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // load more person data
    func loadMoreData() {
        if isWaiting {
            page += 1
            
            var newData: [Person] = []
            
            network.getPersons(page: page) { response in
                newData = response
                DispatchQueue.main.async {
                    self.persons.append(contentsOf: newData)
                    self.collectionView.reloadData()
                    self.isWaiting = false
                }
            }
            
        }
    }
}


// MARK: PersonTableViewDelegate
protocol PersonTableViewDelegate {
    func goToPerson(id: Int)
}
