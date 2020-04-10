//
//  SeeAllViewController.swift
//  iplix
//
//  Created by TEMP on 4/9/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class SeeAllViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    
    var network = ViewController.network
    var isWaiting = false
    var page = 1
    var type = ""
    var movieToSend: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setTitle()
        loadMovies()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: UICollectionView
extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        if indexPath.row == self.movies.count - 10 && !isWaiting {
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
extension SeeAllViewController {
    
    
    // set navigation title
    func setTitle() {
        
        var title: String = ""
        
        switch type {
        case "popular":
            title = "Popular Movies"
            break
        case "now_playing":
            title = "Now Playing Movies"
            break
        case "top_rated":
            title = "Top Rated Movies"
            break
        default:
            title = "Movies"
            break
        }
        
        navigationItem.title = title
        
    }
    
    
    // load movies by type and page
    func loadMovies() {
        network.getMovies(typeMovie: type, page: page) { response in
            self.movies = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // load more movies data
    func loadMoreData() {
        if self.isWaiting {
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
            
//            sleep(2)
        }
    }
    
    
    // prepare before perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetail" {
            if let vc = segue.destination as? MovieDetailViewController {
                if let movieData = movieToSend {
                    vc.movie = movieData
                }
            }
        }
    }
    
    
    // perform segue to movie detail
    func gotoDetail(movie: Movie) {
        movieToSend = movie
        performSegue(withIdentifier:"goToDetail", sender: self)
    }
}
