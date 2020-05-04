//
//  FilterView.swift
//  iplix
//
//  Created by TEMP on 5/4/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class FilterView: UIView {

    let closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    let genre: UILabel = {
        let label = UILabel()
        label.text = "Genres"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let rating: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let ratingValue: UILabel = {
        let label = UILabel()
        label.text = "\u{2265} "
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let sliderRating: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 0
        slider.tintColor = .systemOrange
        slider.thumbTintColor = .systemOrange
        slider.translatesAutoresizingMaskIntoConstraints = false

        return slider
    }()
    
    let resetBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let applyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.3507073532, green: 0.7858502538, blue: 0.7276070304, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        
        addSubview(closeBtn)
        addSubview(genre)
        addSubview(collectionView)
        addSubview(rating)
        addSubview(ratingValue)
        addSubview(sliderRating)
        addSubview(resetBtn)
        addSubview(applyBtn)
        
        NSLayoutConstraint.activate([
        
            // close button constraints
            closeBtn.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // genre label constraints
            genre.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            genre.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            genre.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // collection view constraints
            collectionView.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 16),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            // rating label constraints
            rating.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 25),
            rating.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            rating.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // rating value label constraints
            ratingValue.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 10),
            ratingValue.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            ratingValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // slider rating constraints
            sliderRating.topAnchor.constraint(equalTo: ratingValue.bottomAnchor, constant: 16),
            sliderRating.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            sliderRating.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
         
            // reset button constraints
            resetBtn.topAnchor.constraint(equalTo: sliderRating.bottomAnchor, constant: 50),
            resetBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            resetBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // apply button constraints
            applyBtn.topAnchor.constraint(equalTo: resetBtn.bottomAnchor, constant: 10),
            applyBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            applyBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
        ])
    }

}
