//
//  Extensions.swift
//  iplix
//
//  Created by TEMP on 4/20/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import UIKit


// MARK: UIImageView
extension UIImageView {
    
    // set image corner
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    // make image blury
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    
    // make poster white border line in movie detail
    func addBorderWhiteLine() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
    }
}


// MARK: UIView
extension UIView {

    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
}
