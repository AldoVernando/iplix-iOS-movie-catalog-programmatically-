//
//  AccountView.swift
//  iplix
//
//  Created by TEMP on 4/24/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class AccountView: UIView {

    let accountView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.autoresizesSubviews = true
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
        
        addSubview(accountView)
        
        NSLayoutConstraint.activate([
        
            // account view constraints
            accountView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            accountView.leftAnchor.constraint(equalTo: leftAnchor),
            accountView.rightAnchor.constraint(equalTo: rightAnchor),
            accountView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
