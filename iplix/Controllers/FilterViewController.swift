//
//  FilterViewController.swift
//  iplix
//
//  Created by TEMP on 4/30/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    let closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    let genre: UILabel = {
        let label = UILabel()
        label.text = "Genres"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let applyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.3507073532, green: 0.7858502538, blue: 0.7276070304, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    let network = ViewController.network
    var discover: DiscoverViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(closeBtn)
        view.addSubview(genre)
        view.addSubview(collectionView)
        view.addSubview(applyBtn)
        
        NSLayoutConstraint.activate([
        
            // close button constraints
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            // genre label constraints
            genre.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            genre.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            genre.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // collection view constraints
            collectionView.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 16),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: applyBtn.topAnchor, constant: -100),
         
            // apply button constraints
            applyBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            applyBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            applyBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            
        ])
        
        closeBtn.addTarget(self, action: #selector(closeBtn(_:)), for: .touchUpInside)
        applyBtn.addTarget(self, action: #selector(applyBtn(_:)), for: .touchUpInside)
        
        applyBtn.layer.cornerRadius = 10
        
        collectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    @objc func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func applyBtn(_ sender: UIButton) {
        
        if let par = discover {
            par.loadMovies()
        }
        
        dismiss(animated: true, completion: nil)
    }

}


// MARK: UICollectionView
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return network.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
        
        let genreLabel = network.genres[indexPath.row].name
        cell.genre.text = genreLabel
        cell.layer.cornerRadius = cell.frame.height / 2
        
        let filterGenre = network.filterGenre
        
        for genre in filterGenre {
            if genreLabel == genre.name {
                cell.genre.backgroundColor = .systemOrange
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = network.genres[indexPath.row].name.size(withAttributes: nil)
        
        return CGSize(width: size.width + 50, height: size.height + 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell {
            let selectedGenre = network.genres[indexPath.row]
            
            let genre = network.filterGenre.filter({ $0.id == selectedGenre.id })
            
            if !genre.isEmpty {
                
                let updated = network.filterGenre.filter({ $0.id != selectedGenre.id })
                network.filterGenre = updated
                
                cell.genre.backgroundColor = .systemGray4
            } else {
                network.filterGenre.append(selectedGenre)

                cell.genre.backgroundColor = .systemOrange
            }
            
        }

    }
    
}


// MARK: Functions
extension FilterViewController {
 
    
}
