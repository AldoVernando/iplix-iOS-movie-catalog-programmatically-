//
//  MovieDetailViewController.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class MovieDetailViewController: UIViewController {
    
    let customView = MovieDetailView()
    var navBar: UINavigationBar!
    var poster: UIImageView!
    var foregroundPoster: UIImageView!
    var movieTitle: UILabel!
    var movieReleasedDate: UILabel!
    var rating: UILabel!
    var contentView: UIView!
    
    var backBtn: UIBarButtonItem!
    var favBtn: UIBarButtonItem!
    var aboutBtn: UIBarButtonItem!
    var infoBtn: UIBarButtonItem!
    var reviewBtn: UIBarButtonItem!
    
    let network = ViewController.network
    var movie: Movie?
    let realm = RealmManager()
    var isFavorite = false
    var tempFav: FavoriteMovie?
    var parentView: FavoriteViewController?
    var deviceModel: String?
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar = customView.navBar
        poster = customView.poster
        foregroundPoster = customView.foregroundPoster
        movieTitle = customView.movieTitle
        movieReleasedDate = customView.movieReleasedDate
        rating = customView.rating
        contentView = customView.contentView
        
        backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtn(_:)) )
        backBtn.tintColor = .white
        
        favBtn = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(favBtn(_:)) )
        favBtn.tintColor = .white
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.isTranslucent = true
        
        navigationItem.leftBarButtonItem = backBtn
        navigationItem.rightBarButtonItem = favBtn
        
        
        let navItem = UINavigationItem()
        
        aboutBtn = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(aboutBarBtn(_:)) )
        aboutBtn.tintColor = #colorLiteral(red: 0.2093600929, green: 0.3236650825, blue: 0.4488521814, alpha: 1)
            
        infoBtn = UIBarButtonItem(title: "Information", style: .plain, target: self, action: #selector(infoBarBtn(_:)) )
        infoBtn.tintColor = #colorLiteral(red: 0.2093600929, green: 0.3236650825, blue: 0.4488521814, alpha: 1)
        
        reviewBtn = UIBarButtonItem(title: "Review", style: .plain, target: self, action: #selector(reviewBarBtn(_:)) )
        reviewBtn.tintColor = #colorLiteral(red: 0.2093600929, green: 0.3236650825, blue: 0.4488521814, alpha: 1)
        
        navItem.rightBarButtonItems = [reviewBtn, infoBtn, aboutBtn]
        navBar.setItems([navItem], animated: true)
        
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        aboutBarBtn(aboutBtn)
    }
    
    @objc func backBtn(_ sender: UIBarButtonItem) {
        
        if let parent = parentView {
            parent.getFavorite()
        }
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favBtn(_ sender: UIBarButtonItem) {
        
        changeFav()
    }
    

    @objc func aboutBarBtn(_ sender: UIBarButtonItem) {
        
        changeColor(sender: sender)
        let vc = MovieAboutViewController()
        vc.movie = movie
        changeContentView(view: vc.view)
    }
    
    
    @objc func infoBarBtn(_ sender: UIBarButtonItem) {
        
        changeColor(sender: sender)
        let vc = MovieInformationViewController()
        
        if let mov = movie {
            network.getMovieDetail(movieId: String(mov.id!)) { response in
                vc.movieDetail = response
                DispatchQueue.main.async {
                    self.changeContentView(view: vc.view)
                }
            }
        }
        
    }
    
    
    @objc func reviewBarBtn(_ sender: UIBarButtonItem) {
        
        changeColor(sender: sender)
        let vc = MovieReviewViewController()
        
        if let mov = movie {
            vc.movie = mov
            network.getMovieReview(movieId: String(mov.id!)) { response in
                vc.reviews = response
                DispatchQueue.main.async {
                    self.addChild(vc)
                    self.changeContentView(view: vc.view)
                }
            }
        }
        
    }
    
}


// MARK: Functions
extension MovieDetailViewController {
    
    
    // set up view controller
    func setUp() {
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        checkFavorite()
        poster.addBlurEffect()
        foregroundPoster.addBorderWhiteLine()
        foregroundPoster.setCornerRadius(radius: 10)
        
        if let mov = movie {
            if let backdrop = mov.backdrop_path {
                poster.sd_setImage(with: URL(string: network.posterURL + backdrop))
            }
            if let poster = mov.poster_path {
                foregroundPoster.sd_setImage(with: URL(string: network.posterURL + poster))
            }
            movieTitle.text = mov.title
            movieReleasedDate.text = mov.release_date
            rating.text = String(mov.vote_average!)
        }
        
    }
    
    
    // change selected bar color
    func changeColor(sender: UIBarButtonItem) {
        
        aboutBtn.tintColor = #colorLiteral(red: 0.2093600929, green: 0.3236650825, blue: 0.4488521814, alpha: 1)
        infoBtn.tintColor = #colorLiteral(red: 0.2093600929, green: 0.3236650825, blue: 0.4488521814, alpha: 1)
        reviewBtn.tintColor = #colorLiteral(red: 0.2093600929, green: 0.3236650825, blue: 0.4488521814, alpha: 1)
        sender.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    // change favorite icon
    func changeFav() {
        var image = "bookmark"
        
        if UserDefaults.standard.string(forKey: "userId") == nil {
            Helper.showFavAlert(message: "You must login to add movie to favorite", vc: self)
        }
        else {
            // add to fav
            if isFavorite == false {
                image = "bookmark.fill"
                
                if let mov = movie {
                    
                    let favMovie = FavoriteMovie()
                    favMovie.id = mov.id!
                    favMovie.title = mov.title!
                    favMovie.poster_path = mov.poster_path!
                    
                    if let genreId = mov.genre_ids?.first {
                        let genre = network.genres.filter({ $0.id == genreId })
                        favMovie.genre = genre[0].name
                    } else {
                        favMovie.genre = " "
                    }
                    
                    realm.saveFavMovie(fav: favMovie)
                }
                
            }
            // remove from fav
            else {
                if let data = tempFav {
                    realm.deleteFavMovie(fav: data)
                }
            }
            
            favBtn.image = UIImage(systemName: image)
            
            isFavorite = !isFavorite
        }
    }
    
    
    // check Favorite
    func checkFavorite() {
        let favs = realm.realmInit.objects(FavoriteMovie.self)
        
        if favs.count > 0 {
            if let mov = movie {
                
                for fav in favs {
                    if fav.id == mov.id {
                        isFavorite = true
                        tempFav = fav
                    }
                }
            }
        }
        
        if isFavorite {
            favBtn.image = UIImage(systemName: "bookmark.fill")
        }
        
    }
    
    
    // change content view
    func changeContentView(view: UIView) {
        
        UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve,
        animations: {
            for view in self.contentView.subviews {
                view.removeFromSuperview()
            }
            self.contentView.addSubview(view)
        }, completion: nil)
    }
    
}
