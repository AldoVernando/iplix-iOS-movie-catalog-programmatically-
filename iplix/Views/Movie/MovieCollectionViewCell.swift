//
//  MovieCollectionViewCell.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        poster.setCornerRadius(radius: 10)
    }

}
