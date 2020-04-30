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
        
        let accountBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(accountBtn(_:)) )
        
        navigationItem.rightBarButtonItem = accountBtn
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [ .font: UIFont.systemFont(ofSize: 30) ]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.title = "Iplix"
        
        let homeController = ViewController()
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let discoverController = DiscoverViewController()
        discoverController.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "wand.and.stars"), tag: 1)
        
        let favoriteController = FavoriteViewController()
        favoriteController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 2)
        
        let searchController = SearchViewController()
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        
        let tabBarList = [homeController, discoverController, favoriteController, searchController]
        
        viewControllers = tabBarList
    }
    
    @objc func accountBtn(_ sender: UIBarButtonItem) {
        
        let vc = AccountViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
