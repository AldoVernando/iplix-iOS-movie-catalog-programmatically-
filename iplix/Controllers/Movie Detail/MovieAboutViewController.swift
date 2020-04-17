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

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var trailerView: WKYTPlayerView!
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    var movie: Movie?
    let network = ViewController.network
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mov = movie {
            overview.text = mov.overview
            showTrailer(id: mov.id!)
        }
        
        
        
    }
    
    // set scrollview height
    override func viewDidAppear(_ animated: Bool) {
        scroller.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
                self.trailerView.removeFromSuperview()
                self.overview.topAnchor.constraint(equalTo: self.aboutLabel.bottomAnchor, constant: 16).isActive = true
            }
        }
    }
}
