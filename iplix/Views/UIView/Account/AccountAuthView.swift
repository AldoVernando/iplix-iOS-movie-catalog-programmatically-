//
//  AccountAuthView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountAuthView: UIView {

    let segmentedControl: UISegmentedControl = {
        let items = ["Login", "Register"]
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        return segment
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
        
        addSubview(segmentedControl)
        
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
        
            // segemented control constraints
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            segmentedControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            segmentedControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            // content view constraints
            contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
