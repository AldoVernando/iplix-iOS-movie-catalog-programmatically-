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
    
    var backBtn: UIBarButtonItem!
    var favBtn: UIBarButtonItem!
    var aboutBtn: UIBarButtonItem!
    var infoBtn: UIBarButtonItem!
    var reviewBtn: UIBarButtonItem!
    
    private let poster: UIImageView = {
        let image = UIImageView(image: UIImage(named: "poster"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let foregroundPoster: UIImageView = {
        let image = UIImageView(image: UIImage(named: "poster"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let navBar: UINavigationBar = {
        let nav = UINavigationBar()
        nav.barTintColor = #colorLiteral(red: 0.3507073532, green: 0.7858502538, blue: 0.7276070304, alpha: 1)
        nav.translatesAutoresizingMaskIntoConstraints = false
        
        return nav
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.text = "The Avengers : End Game"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let movieReleasedDate: UILabel = {
        let label = UILabel()
        label.text = "2020-01-03"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.text = "8.5"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let star: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "star.fill"))
        image.tintColor = .white
        image.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    let network = ViewController.network
    var movie: Movie?
    let realm = RealmManager()
    var isFavorite = false
    var tempFav: FavoriteMovie?
    var parentView: FavoriteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtn(_:)) )
        backBtn.tintColor = .white
        
        favBtn = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(backBtn(_:)) )
        favBtn.tintColor = .white
        
//        navigationItem.backBarButtonItem = backBtn
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
        
        
        view.addSubview(poster)
        view.addSubview(navBar)
        view.addSubview(foregroundPoster)
        view.addSubview(movieTitle)
        view.addSubview(movieReleasedDate)
        view.addSubview(rating)
        view.addSubview(star)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            // background poster constraints
            poster.topAnchor.constraint(equalTo: view.topAnchor),
            poster.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            poster.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            poster.heightAnchor.constraint(equalToConstant: 300),
            
            // foreground poster constraints
            foregroundPoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            foregroundPoster.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            foregroundPoster.heightAnchor.constraint(equalToConstant: 220),
            foregroundPoster.widthAnchor.constraint(equalToConstant: 150),
            
            // navigation bar constraints
            navBar.topAnchor.constraint(equalTo: poster.bottomAnchor),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // movie title constraints
            movieTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movieTitle.leftAnchor.constraint(equalTo: foregroundPoster.rightAnchor, constant: 16),
            movieTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // movie released date constraints
            movieReleasedDate.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 20),
            movieReleasedDate.leftAnchor.constraint(equalTo: foregroundPoster.rightAnchor, constant: 16),
            movieReleasedDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // movie rating constraints
            rating.topAnchor.constraint(equalTo: movieReleasedDate.bottomAnchor, constant: 20),
            rating.leftAnchor.constraint(equalTo: foregroundPoster.rightAnchor, constant: 16),
            
            // star image constraints
            star.topAnchor.constraint(equalTo: movieReleasedDate.bottomAnchor, constant: 20),
            star.leftAnchor.constraint(equalTo: rating.rightAnchor, constant: 5),
            
            // content view constraints
            contentView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        aboutBarBtn(aboutBtn)
    }
    
    @objc func backBtn(_ sender: UIBarButtonItem) {
        
        if let parent = parentView {
            parent.getFavorite()
        }
        
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
