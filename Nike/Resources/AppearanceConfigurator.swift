//
//  AppearanceConfigurator.swift
//  Nike
//
//  Created by Александр Милейчик on 5/29/25.
//

import UIKit

struct AppearanceConfigurator {
    static func configure() {
        
        //MARK: - NavigationBarConfigurator
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        //MARK: - TabBarConfigurator
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    //MARK: - TabBarItemAppearance
    static func configureTabBarItemAppearance(for item: UITabBarItem) {
        item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
}
