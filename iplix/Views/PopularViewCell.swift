//
//  PopularViewCell.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import SDWebImage

protocol ViewCellDelegator {
    func gotoDetail(movie: Movie)
    func goToAll(type: String)
}

class PopularViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var viewCollection: UICollectionView!
    
    var network = NetworkManager.networkInstance
    var movies: [Movie] = []
    var delegate: ViewCellDelegator!
    var type: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewCollection.dataSource = self
        viewCollection.delegate = self
        viewCollection.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
        delegate.goToAll(type: type)
    }
    
}

//MARK: - UICollectionView
extension PopularViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        
        cell.title.text = movies[indexPath.row].title!
    
        if let poster = movies[indexPath.row].poster_path {
            cell.poster.sd_setImage(with: URL(string: network.posterURL + poster))
        }
        
        if let genreId = movies[indexPath.row].genre_ids?.first {
            let genre = network.genres.filter({ $0.id == genreId })
            cell.genre.text = genre[0].name
        } else {
            cell.genre.text = " "
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getMovie = movies[indexPath.row]
        delegate.gotoDetail(movie: getMovie)
    }
}


// MARK: Functions
extension PopularViewCell {
    
    func loadMovies(typeMovie: String){
        
        network.getMovies(typeMovie: typeMovie, page: 1) { response in
            self.movies = response
            DispatchQueue.main.async {
                self.viewCollection.reloadData()
            }
        }
        
    }
}
