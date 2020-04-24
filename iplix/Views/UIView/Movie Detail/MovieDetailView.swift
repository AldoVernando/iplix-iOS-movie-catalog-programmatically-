//
//  MovieDetailView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {

    let poster: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background-image"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let foregroundPoster: UIImageView = {
        let image = UIImageView(image: UIImage(named: "poster"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let navBar: UINavigationBar = {
        let nav = UINavigationBar()
        nav.barTintColor = #colorLiteral(red: 0.3507073532, green: 0.7858502538, blue: 0.7276070304, alpha: 1)
        nav.translatesAutoresizingMaskIntoConstraints = false
        
        return nav
    }()
    
    let movieTitle: UILabel = {
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
    
    let movieReleasedDate: UILabel = {
        let label = UILabel()
        label.text = "2020-01-03"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let rating: UILabel = {
        let label = UILabel()
        label.text = "8.5"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let star: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "star.fill"))
        image.tintColor = .white
        image.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubviews()
    }
    
    func createSubviews() {
        
        backgroundColor = .white
        
        addSubview(poster)
        addSubview(navBar)
        addSubview(foregroundPoster)
        addSubview(movieTitle)
        addSubview(movieReleasedDate)
        addSubview(rating)
        addSubview(star)
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            // background poster constraints
            poster.topAnchor.constraint(equalTo: topAnchor),
            poster.leftAnchor.constraint(equalTo: leftAnchor),
            poster.rightAnchor.constraint(equalTo: rightAnchor),
            poster.heightAnchor.constraint(equalToConstant: 300),
            
            // foreground poster constraints
            foregroundPoster.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            foregroundPoster.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            foregroundPoster.heightAnchor.constraint(equalToConstant: 220),
            foregroundPoster.widthAnchor.constraint(equalToConstant: 150),
            
            // navigation bar constraints
            navBar.topAnchor.constraint(equalTo: poster.bottomAnchor),
            navBar.leftAnchor.constraint(equalTo: leftAnchor),
            navBar.rightAnchor.constraint(equalTo: rightAnchor),
            
            // movie title constraints
            movieTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            movieTitle.leftAnchor.constraint(equalTo: foregroundPoster.rightAnchor, constant: 16),
            movieTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // movie released date constraints
            movieReleasedDate.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 20),
            movieReleasedDate.leftAnchor.constraint(equalTo: foregroundPoster.rightAnchor, constant: 16),
            movieReleasedDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // movie rating constraints
            rating.topAnchor.constraint(equalTo: movieReleasedDate.bottomAnchor, constant: 20),
            rating.leftAnchor.constraint(equalTo: foregroundPoster.rightAnchor, constant: 16),
            
            // star image constraints
            star.topAnchor.constraint(equalTo: movieReleasedDate.bottomAnchor, constant: 20),
            star.leftAnchor.constraint(equalTo: rating.rightAnchor, constant: 5),
            
            // content view constraints
            contentView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
