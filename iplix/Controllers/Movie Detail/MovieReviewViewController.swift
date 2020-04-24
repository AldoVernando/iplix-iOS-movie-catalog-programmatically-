//
//  MovieReviewViewController.swift
//  iplix
//
//  Created by TEMP on 4/9/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieReviewViewController: UIViewController {

    let customView = MovieReviewView()
    var tableView: UITableView!

    var reviews: [Review] = []
    var movie: Movie?
    var network = ViewController.network
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = customView.tableView
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350)
        
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
    }
    
}


// MARK: UITableView
extension MovieReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
            
            let review = reviews[indexPath.row]
            
            cell.author.text = review.author
            cell.content.text = review.content
            
            return cell
        
//        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "review", for: indexPath)
//
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
