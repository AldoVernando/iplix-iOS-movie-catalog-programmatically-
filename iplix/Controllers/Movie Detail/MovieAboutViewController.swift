//
//  MovieAboutViewController.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieAboutViewController: UIViewController {

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var overview: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mov = movie {
            overview.text = mov.overview
        }
        
    }
    
    
    // set scrollview height
    override func viewDidAppear(_ animated: Bool) {
        scroller.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+500)
    }

}
