//
//  PopularViewCell.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import SDWebImage

class PopularViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var network = ViewController.network
    var movies: [Movie] = []
    var delegate: PopularViewCellDelegate!
    var type: String = ""
    var isWaiting = false
    var page = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        collectionView.register(UINib(nibName: "LoadingViewCell", bundle: nil), forCellWithReuseIdentifier: "loadingCell")
    }
    
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
        delegate.goToAll(type: type)
    }
}


//MARK: - UICollectionView
extension PopularViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < movies.count {
        
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! LoadingViewCell
            cell.loading.startAnimating()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row < movies.count {
            let getMovie = movies[indexPath.row]
            delegate.gotoDetail(movie: getMovie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == movies.count && !isWaiting {
          isWaiting = true
          loadMoreData()
        }
    }
    
}


// MARK: Functions
extension PopularViewCell {
    
    
    // load movies data
    func loadMovies(typeMovie: String){
        
        network.getMovies(typeMovie: typeMovie, page: 1) { response in
            self.movies = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    
    // load more movies data
    func loadMoreData() {
        if isWaiting {
            page += 1
            
            var newData: [Movie] = []
            
            network.getMovies(typeMovie: type, page: page) { response in
                newData = response
                DispatchQueue.main.async {
                    self.movies.append(contentsOf: newData)
                    self.collectionView.reloadData()
                    self.isWaiting = false
                }
            }
            
        }
    }
}


// MARK: PopularViewCellDelegate
protocol PopularViewCellDelegate {
    func gotoDetail(movie: Movie)
    func goToAll(type: String)
}
