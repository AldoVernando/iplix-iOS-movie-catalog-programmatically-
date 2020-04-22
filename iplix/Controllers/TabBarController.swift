//
//  TabBarController.swift
//  iplix
//
//  Created by TEMP on 4/22/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Iplix"
        
        let homeController = ViewController()
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let favoriteController = FavoriteViewController()
        favoriteController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        let searchController = SearchViewController()
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let tabBarList = [homeController, favoriteController, searchController]
        
        viewControllers = tabBarList
    }
    
}
