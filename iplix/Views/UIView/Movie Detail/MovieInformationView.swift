//
//  MovieInformationView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieInformationView: UIView {

    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let genre: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let language: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Production Companies"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let companies: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Production Countries"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let countries: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
