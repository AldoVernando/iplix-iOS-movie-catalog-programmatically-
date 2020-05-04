//
//  FilterViewController.swift
//  iplix
//
//  Created by TEMP on 4/30/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    let customView = FilterView()
    var closeBtn: UIButton!
    var collectionView: UICollectionView!
    var ratingValue: UILabel!
    var sliderRating: UISlider!
    var resetBtn: UIButton!
    var applyBtn: UIButton!

    let network = ViewController.network
    var discover: DiscoverViewController?
    var currentRating: Float = 0
    var currentGenre: [Genre] = []
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeBtn = customView.closeBtn
        collectionView = customView.collectionView
        ratingValue = customView.ratingValue
        sliderRating = customView.sliderRating
        resetBtn = customView.resetBtn
        applyBtn = customView.applyBtn
        
        closeBtn.addTarget(self, action: #selector(closeBtn(_:)), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(resetBtn(_:)), for: .touchUpInside)
        applyBtn.addTarget(self, action: #selector(applyBtn(_:)), for: .touchUpInside)
        sliderRating.addTarget(self, action: #selector(ratingChange(_:)), for: .valueChanged)
        
        ratingValue.text! += String(network.rating)
        sliderRating.value = network.rating
        
        collectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    @objc func ratingChange(_ sender: UISlider) {
        ratingValue.text = "\u{2265} " + String(format: "%.1f", sender.value)
        currentRating = Float(String(format: "%.1f", sender.value)) ?? 0
    }
    
    @objc func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func resetBtn(_ sender: UIButton) {
        currentGenre.removeAll()
        currentRating = 0
        
        for cell in collectionView.visibleCells {
            let genreCell = cell as! GenreCollectionViewCell
            genreCell.genre.backgroundColor = .systemGray4
        }
        
        sliderRating.value = 0
        ratingValue.text = "\u{2265} 0"
    }
    
    @objc func applyBtn(_ sender: UIButton) {
        
        network.rating = currentRating
        network.filterGenre = currentGenre
        
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
                currentGenre.append(genre)
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
                
                let updated = currentGenre.filter({ $0.id != selectedGenre.id })
                currentGenre = updated
                
                cell.genre.backgroundColor = .systemGray4
            } else {
                currentGenre.append(selectedGenre)

                cell.genre.backgroundColor = .systemOrange
            }
            
        }

    }
    
}


// MARK: Functions
extension FilterViewController {
 
    
}
