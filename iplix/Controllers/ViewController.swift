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

    let customView = HomeView()
    var tableView: UITableView!
    
    static let network = NetworkManager()
    var item = 0
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = customView.tableView
        
        setUp()
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
    
    
    // set up view controller
    func setUp() {
        
        ViewController.network.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "PopularViewCell", bundle: nil), forCellReuseIdentifier: "popularCell")
        tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
    }
    
    
    // reload table view
    func reloadTableView() {
        item = 4
        tableView.reloadData()
    }
    
    
    // go to movie detail
    func gotoDetail(movie: Movie) {
        
        let vc = MovieDetailViewController()
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // go to all movies
    func goToAll(type: String) {
        
        let vc = SeeAllViewController()
        vc.type = type
        navigationController?.pushViewController(vc, animated: true)
     }
    
    
    // go to person detail
    func goToPerson(id: Int) {
        
        let vc = PersonDetailViewController()
        vc.personId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
