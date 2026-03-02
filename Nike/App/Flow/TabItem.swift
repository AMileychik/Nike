//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppCore
import AppInterface

// MARK: - TabItem

/// Represents a single tab in the MainTabBarController.
///
/// Responsibilities:
/// - Provides title and image for each tab.
/// - Determines which tabs are available based on `AppConfiguration`.
/// - Creates the root view controller for the tab along with its coordinator.
public enum TabItem: CaseIterable {
    case home
    case bag
    
    // MARK: - Available Tabs
    
    /// Returns tabs that are enabled according to the app configuration.
    ///
    /// - Parameter config: App configuration containing feature flags.
    /// - Returns: Array of `TabItem` that should be visible in the tab bar.
    public static func availableTabs(config: AppConfiguration) -> [TabItem] {
        var tabs: [TabItem] = []
        if config.bool(.home) { tabs.append(.home) }
        if config.bool(.bag) { tabs.append(.bag) }
        return tabs
    }
    
    // MARK: - Tab Properties
    
    /// The display title for the tab.
    public var title: String {
        switch self {
        case .home: return "Home"
        case .bag: return "Bag"
        }
    }
    
    /// The system image name for the tab icon.
    public var image: String {
        switch self {
        case .home: return "house"
        case .bag: return "bag"
        }
    }
    
    // MARK: - Coordinator Integration
    
    /// Creates the root view controller for the tab and attaches its coordinator.
    ///
    /// - Parameters:
    ///   - dependencies: App-wide dependencies used to create the coordinator.
    ///   - onCoordinatorCreated: Callback invoked when the coordinator is created.
    /// - Returns: A configured `UIViewController` wrapped in a `UINavigationController`.
    public func createViewController(
        from dependencies: AppDependenciesProtocol,
        onCoordinatorCreated: @escaping (CoordinatorProtocol) -> Void
    ) -> UIViewController {
        switch self {
        case .home:
            return makeCoordinatorTab(
                using: dependencies.home.makeCoordinator,
                onCoordinatorCreated: onCoordinatorCreated
            )
        case .bag:
            return makeCoordinatorTab(
                using: dependencies.bag.makeCoordinator,
                onCoordinatorCreated: onCoordinatorCreated
            )
        }
    }
    
    // MARK: - Private Helpers
    
    /// Creates a UINavigationController for the tab and initializes its coordinator.
    ///
    /// - Parameters:
    ///   - factory: A factory that creates the coordinator given a UINavigationController.
    ///   - onCoordinatorCreated: Callback invoked when the coordinator is created.
    /// - Returns: The navigation controller with the coordinator's root view controller set.
    private func makeCoordinatorTab(
        using factory: (UINavigationController) -> CoordinatorProtocol,
        onCoordinatorCreated: (CoordinatorProtocol) -> Void
    ) -> UIViewController {
        let nav = UINavigationController()
        let coordinator = factory(nav)
        onCoordinatorCreated(coordinator)
        nav.viewControllers = [coordinator.start()]
        return nav
    }
}
