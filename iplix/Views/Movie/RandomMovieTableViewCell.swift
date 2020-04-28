//
//  RandomMovieTableViewCell.swift
//  iplix
//
//  Created by TEMP on 4/28/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class RandomMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var randomBtn: UIButton!
    
    let network = ViewController.network
    var movie: Movie?
    var delegate: PopularViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        poster.setCornerRadius(radius: 10)
        randomBtn.layer.cornerRadius = 10
        loadRandomMovie()
    }

    @IBAction func detailBtnPressed(_ sender: UIButton) {
        if let mov = movie {
            delegate.gotoDetail(movie: mov)
        }
    }
    
    @IBAction func randomBtnPressed(_ sender: UIButton) {
        loadRandomMovie()
    }
    
}


// MARK: Functions
extension RandomMovieTableViewCell {
    
    
    // load movies data
    func loadRandomMovie(){
        
        loading.startAnimating()
        
        network.getRandomMovie() { response in
            self.movie = response
            
            self.title.text = response.title
            if let genreId = response.genre_ids?.first {
                let genre = self.network.genres.filter({ $0.id == genreId })
                self.genre.text = genre[0].name
            } else {
                self.genre.text = " "
            }
            self.synopsis.text = response.overview
            if let poster = response.poster_path {
                self.poster.sd_setImage(with: URL(string: self.network.posterURL + poster))
            } else {
                self.poster.image = UIImage(named: "poster")
            }
            
            self.loading.stopAnimating()
        }
        
    }
}
