//
//  DiscoverViewController.swift
//  iplix
//
//  Created by TEMP on 4/30/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    let customView = DiscoverView()
    var collectionView: UICollectionView!
    var filterBtn: UIButton!
    var message: UILabel!
    
    var movies: [Movie] = []
    var network = ViewController.network
    var isWaiting = false
    var page = 1
    var type = ""
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = customView.collectionView
        filterBtn = customView.filterBtn
        message = customView.message
        
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtn(_:)) )
        
        filterBtn.addTarget(self, action: #selector(filterBtn(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = backBtn
        
        setUp()
    }
    
    @objc func backBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterBtn(_ sender: UIButton) {
        let vc = FilterViewController()
        vc.discover = self
        present(vc, animated: true, completion: nil)
    }
    
}


// MARK: UICollectionView
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let mov = movies[indexPath.row]
        gotoDetail(movie: mov)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == movies.count - 10 && !isWaiting {
          isWaiting = true
          loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = (collectionView.bounds.width/3.0) - 20
        
        let yourHeight = CGFloat(220)

        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


// MARK: Functions
extension DiscoverViewController {
    
    
    // set up view controller
    func setUp() {
        
        loadMovies()
        collectionView.delegate = self
        collectionView.dataSource = self
        filterBtn.layer.cornerRadius = 25
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    
    // load movies by type and page
    func loadMovies() {
        page = 1
        network.getDiscoverMovies(page: 1)  { response in
            self.movies = response
            DispatchQueue.main.async {
                if self.movies.isEmpty {
                    self.message.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.message.isHidden = true
                    self.collectionView.isHidden = false
                }
                
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // load more movies data
    func loadMoreData() {
        if isWaiting {
            page += 1
            
            var newData: [Movie] = []
            
            network.getDiscoverMovies(page: page) { response in
                newData = response
                if !newData.isEmpty {
                    DispatchQueue.main.async {
                        self.movies.append(contentsOf: newData)
                        self.collectionView.reloadData()
                        self.isWaiting = false
                    }
                }
            }
            
        }
    }
    
    
    // go to movie detail
    func gotoDetail(movie: Movie) {
        let vc = MovieDetailViewController()
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }

}
