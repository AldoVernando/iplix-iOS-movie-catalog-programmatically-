//
//  FavoriteViewController.swift
//  iplix
//
//  Created by TEMP on 4/16/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var message: UILabel!
    
    let realm = RealmManager()
    var movies: [FavoriteMovie] = []
    let network = ViewController.network
    var movieToSend: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
        
}


// MARK: UITableView
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {
            fatalError("error")
        }
        
        let movie = movies[indexPath.row]
        
        cell.poster.sd_setImage(with: URL(string: network.posterURL + movie.poster_path))
        cell.title.text = movie.title
        cell.genre.text = movie.genre
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoDetail(movie: movies[indexPath.row])
    }
    
}


// MARK: Functions
extension FavoriteViewController {
    
    
    // set up view controller
    func setUp() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        
        getFavorite()
        
    }
    
    
    // get favorite
    func getFavorite() {
        let favs = realm.realmInit.objects(FavoriteMovie.self)
        movies.removeAll()
        
        if favs.count > 0 {
            
            tableView.isHidden = false
            message.isHidden = true
            
            for fav in favs {
                movies.append(fav)
            }
            
            
        } else {
            
            message.isHidden = false
            tableView.isHidden = true
            
        }
        tableView.reloadData()
    }
    
    
    // prepare before perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetail" {
            if let vc = segue.destination as? MovieDetailViewController {
                if let movieData = movieToSend {
                    vc.movie = movieData
                    vc.parentView = self
                }
            }
        }
    }
    
    
    // perform segue to movie detail
    func gotoDetail(movie: FavoriteMovie) {

        network.getMovieforFav(movieId: String(movie.id)) { response in
            
            self.movieToSend = response
            self.performSegue(withIdentifier:"goToDetail", sender: self)
        }
        
    }
    
}
