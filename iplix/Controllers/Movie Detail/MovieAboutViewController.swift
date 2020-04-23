//
//  MovieAboutViewController.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MovieAboutViewController: UIViewController {
    
    var movie: Movie?
    let network = ViewController.network
    
    private let scroller: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let trailerView: WKYTPlayerView = {
        let view = WKYTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.addSubview(aboutLabel)
        content.addSubview(trailerView)
        content.addSubview(overview)
        
        scroller.addSubview(content)
        
        view.backgroundColor = .white
        view.addSubview(scroller)
        
        
        NSLayoutConstraint.activate([

            // scroll view constraints
            scroller.topAnchor.constraint(equalTo: view.topAnchor),
            scroller.leftAnchor.constraint(equalTo: view.leftAnchor),
            scroller.rightAnchor.constraint(equalTo: view.rightAnchor),
            scroller.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scroller.heightAnchor.constraint(equalTo: view.heightAnchor),
//            scroller.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            // content view constraints
            content.topAnchor.constraint(equalTo: scroller.topAnchor),
            content.leftAnchor.constraint(equalTo: scroller.leftAnchor),
            content.rightAnchor.constraint(equalTo: scroller.rightAnchor),
            content.bottomAnchor.constraint(equalTo: scroller.bottomAnchor),
            content.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            
            // about label constraints
            aboutLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
            aboutLabel.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16),
            aboutLabel.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -16),

            // trailer view constraints
            trailerView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 20),
            trailerView.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16),
            trailerView.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -16),
            trailerView.heightAnchor.constraint(equalToConstant: 200),
            
            // overview constraints
            overview.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 20),
            overview.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 16),
            overview.rightAnchor.constraint(equalTo: content.rightAnchor, constant: -16),
            overview.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -20)
            
        ])
        
        if let mov = movie {
            overview.text = mov.overview
            overview.text! += mov.overview!
            overview.text! += mov.overview!
            showTrailer(id: mov.id!)
        }
    
    }
    
    
    
//     set scrollview height
    override func viewDidAppear(_ animated: Bool) {
        scroller.contentSize = CGSize(width: UIScreen.main.bounds.width, height: content.frame.height + 350)
    }

}


// MARK: Functions
extension MovieAboutViewController {
 
    
    // show movie trailer
    func showTrailer(id: Int) {
        
        network.getVideoURL(id: id) { response in
            
            if response.count > 1 {
                self.trailerView.load(withVideoId: response[1].key!)
            }
            else {
//                self.trailerView.removeFromSuperview()
//                self.overview.topAnchor.constraint(equalTo: self.aboutLabel.bottomAnchor, constant: 16).isActive = true
            }
        }
    }
}
