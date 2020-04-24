//
//  MovieReviewView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieReviewView: UIView {

    let tableView: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
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
        
    }

}
