//
//  ViewController.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, NetworkDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieToSend: Movie?
    var type: String = ""
    var personId: Int = 0
    static let network = NetworkManager()
    var item = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController.network.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "PopularViewCell", bundle: nil), forCellReuseIdentifier: "popularCell")
        tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        
    }

}


//MARK: - UITableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell",for: indexPath) as! PopularViewCell
            cell.categoryTitle.text = "Popular"
            cell.loadMovies(typeMovie: "popular")
            cell.delegate = self
            cell.type = "popular"
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
            cell.delegate = self
            
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularViewCell
            cell.categoryTitle.text = "Now Playing"
            cell.loadMovies(typeMovie: "now_playing")
            cell.delegate = self
            cell.type = "now_playing"
            return cell
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularViewCell
            cell.categoryTitle.text = "Top Rated"
            cell.loadMovies(typeMovie: "top_rated")
            cell.delegate = self
            cell.type = "top_rated"
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 180
        }
        return 300
    }
}


// MARK: Functions
extension ViewController: PopularViewCellDelegate, PersonTableViewDelegate {
    
    
    // reload table view
    func reloadTableView() {
        item = 4
        tableView.reloadData()
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
        if segue.identifier == "goToSeeAll" {
            if let vc = segue.destination as? SeeAllViewController {
                    vc.type = type
            }
        }
        if segue.identifier == "goToPerson" {
            if let vc = segue.destination as? PersonDetailViewController {
                vc.personId = personId
            }
        }
    }
    
    // perform segue to account
    func goToAccount() {
        performSegue(withIdentifier:"goToAccount", sender: self)
    }
    
    
    // perform segue to movie detail
    func gotoDetail(movie: Movie) {
        movieToSend = movie
        performSegue(withIdentifier:"goToDetail", sender: self)
    }
    
    
    // perform segue to all movies
    func goToAll(type: String) {
        self.type = type
        performSegue(withIdentifier: "goToSeeAll", sender: self)
     }
    
    
    // perform segue to person detail
    func goToPerson(id: Int) {
        self.personId = id
        performSegue(withIdentifier: "goToPerson", sender: self)
    }
}
