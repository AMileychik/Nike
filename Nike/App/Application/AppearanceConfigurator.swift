//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit

// MARK: - AppearanceConfigurator

/// A centralized configurator for app-wide UI appearance.
///
/// Responsibilities:
/// - Configures `UINavigationBar` appearance for the entire app.
/// - Configures `UITabBar` appearance, including icons and text for selected and normal states.
/// - Provides a helper to configure individual `UITabBarItem` appearance.
public struct AppearanceConfigurator {
    
    // MARK: - Public API
    
    /// Applies global appearance settings for navigation bars and tab bars.
    public static func configure() {
        
        // MARK: - NavigationBar Appearance
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground() // Use opaque background to avoid transparency
        navigationAppearance.backgroundColor = .white           // Set background color
        navigationAppearance.shadowColor = .clear              // Remove bottom shadow
        
        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = navigationAppearance
        navBar.scrollEdgeAppearance = navigationAppearance    // iOS 15+ scroll edge appearance
        
        // MARK: - TabBar Appearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.shadowColor = .clear
        
        // Configure icon colors for selected and normal states
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        
        // Configure title text attributes for selected and normal states
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
        
        tabBar.tintColor = .black // Default tint color for selected items
    }
    
    /// Configures the appearance of a single `UITabBarItem`.
    ///
    /// - Parameter item: The `UITabBarItem` to configure.
    public static func configureTabBarItemAppearance(for item: UITabBarItem) {
        item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
}

