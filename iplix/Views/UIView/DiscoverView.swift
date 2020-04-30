//
//  DiscoverView.swift
//  iplix
//
//  Created by TEMP on 4/30/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class DiscoverView: UIView {

    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    let filterBtn: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.backgroundColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.text = "No movies that fit the criteria"
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
        
        backgroundColor = .white
        
        addSubview(collectionView)
        addSubview(filterBtn)
        addSubview(message)
        
        NSLayoutConstraint.activate([
            
            // collection view constraints
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            // filter button constraints
            filterBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            filterBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // message constraints
            message.centerXAnchor.constraint(equalTo: centerXAnchor),
            message.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
        
    }

}
