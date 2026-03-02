//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit

//public enum AppConfigurator {
//    public static func configureAppearance() {
//        AppearanceConfigurator.configure()
//    }


// or another appearance settings

//}

public struct AppearanceConfigurator {
    
    public static func configure() {
        // MARK: - NavigationBar Appearance
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = .white
        navigationAppearance.shadowColor = .clear
        
        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = navigationAppearance
        navBar.scrollEdgeAppearance = navigationAppearance

        // MARK: - TabBar Appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.shadowColor = .clear
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.lightGray
        ]
        
        let tabBar = UITabBar.appearance()
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        tabBar.tintColor = .black
    }
    
    public static func configureTabBarItemAppearance(for item: UITabBarItem) {
        item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
}
