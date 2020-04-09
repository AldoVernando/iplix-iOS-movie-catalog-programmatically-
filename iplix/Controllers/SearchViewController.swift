//
//  SearchViewController.swift
//  iplix
//
//  Created by TEMP on 4/8/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import PaginatedTableView
import SDWebImage

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: PaginatedTableView!
    
    var movieToSend: Movie?
    var movies: [Movie] = []
    var firstPage: [Movie] = []
    var network = NetworkManager.networkInstance
    var searchQuery: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.paginatedDelegate = self
        tableView.paginatedDataSource = self
        tableView.enablePullToRefresh = true
        tableView.pullToRefreshTitle = NSAttributedString(string: "Pull to Refresh")
        tableView.loadData(refresh: true)
        
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        
        hideKeyboardWhenTappedAround()
    }
    
}


// MARK: PaginatedTableViewDelegate & PaginatedTableViewDataSource
extension SearchViewController: PaginatedTableViewDelegate, PaginatedTableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        
        if movies.isEmpty {
            loadMovies()
            onSuccess?(true)
        }
        else if pageNumber == 1 {
            movies = firstPage
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onSuccess?(true)
            }
        }
        else {
            network.getMovieWithQuery(query: searchQuery ,page: pageNumber)
            { response in
                self.movies.append(contentsOf: response)
                
                let moreData = !response.isEmpty
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    onSuccess?(moreData)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {
            fatalError("error")
        }
        
        if movies.isEmpty {
            
        }
        
        let movie = movies[indexPath.row]
        
        if let posterPath = movie.poster_path {
            cell.poster.sd_setImage(with: URL(string: network.posterURL + posterPath))
        }
        cell.title.text = movie.title
        
        if let genreId = movie.genre_ids?.first {
            let genre = network.genres.filter({ $0.id == genreId })
            cell.genre.text = genre[0].name
        } else {
            cell.genre.text = " "
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoDetail(movie: movies[indexPath.row])
    }
}


// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
        loadMovies()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
}


// MARK: SearchViewController Functions
extension SearchViewController {
    
    
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
    
    
    // dismiss keyboard when tapped out of keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    
    // dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // load movies by query
    func loadMovies() {
        network.getMovieWithQuery(query: searchQuery, page: 1) { response in
            self.movies = response
            self.firstPage = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // perform segue to movie detail
    func gotoDetail(movie: Movie) {
        movieToSend = movie
        performSegue(withIdentifier:"goToDetail", sender: self)
    }
    
}
