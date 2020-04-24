//
//  Helper.swift
//  iplix
//
//  Created by TEMP on 4/21/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    
    // show alert
    static func showAlert(message: String, vc: UIViewController) {
       let alertController = UIAlertController(title: "Information", message:
           message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

       vc.present(alertController, animated: true, completion: nil)
   }
    
    
    // show alert for fav movie
    static func showFavAlert(message: String, vc: UIViewController) {
        let alertController = UIAlertController(title: "Information", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: { response in
            
            let loginVC = AccountViewController()
            
            vc.navigationController?.pushViewController(loginVC, animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        vc.present(alertController, animated: true, completion: nil)
    }
    
}
