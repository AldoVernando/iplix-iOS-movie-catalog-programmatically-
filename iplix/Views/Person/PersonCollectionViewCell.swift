//
//  PersonCollectionViewCell.swift
//  iplix
//
//  Created by TEMP on 4/10/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
    }

}
