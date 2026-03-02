//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppCore
import AppInterface

// MARK: - MainTabBarController

/// The main tab bar controller of the application.
///
/// Responsibilities:
/// - Sets up tabs based on available features in `AppConfiguration`.
/// - Creates view controllers for each tab using `AppDependenciesProtocol`.
/// - Manages child coordinators for each tab.
/// - Handles re-selection of the current tab to scroll content to top.
public final class MainTabBarController: UITabBarController {
    
    // MARK: - Dependencies
    
    /// App-wide dependencies including feature modules and UI factories.
    private let dependencies: AppDependenciesProtocol
    
    /// App configuration containing enabled features and flow type.
    private let configuration: AppConfiguration
    
    // MARK: - State
    
    /// List of coordinators managing each tab’s flow.
    private var coordinators: [CoordinatorProtocol] = []
    
    /// Index of the last selected tab to handle scroll-to-top behavior.
    private var lastSelectedIndex: Int?
    
    // MARK: - Initialization
    
    /// Initializes the main tab bar controller with dependencies and configuration.
    ///
    /// - Parameters:
    ///   - dependencies: App-wide dependencies container.
    ///   - configuration: App configuration containing flow type and feature flags.
    public init(dependencies: AppDependenciesProtocol, configuration: AppConfiguration) {
        self.dependencies = dependencies
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Not supported from storyboard/XIB.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabs()
    }
    
    // MARK: - Tab Configuration
    
    /// Configures all available tabs based on the app configuration.
    ///
    /// - Creates view controllers via `TabItem.createViewController(from:)`.
    /// - Sets tab bar items with title, image, and tag.
    /// - Initializes `coordinators` for each tab.
    private func configureTabs() {
        let availableTabs = TabItem.availableTabs(config: configuration)
        
        viewControllers = availableTabs.enumerated().map { index, tab in
            let vc = tab.createViewController(from: dependencies) { [weak self] coordinator in
                self?.coordinators.append(coordinator)
            }
            
            vc.tabBarItem = UITabBarItem(
                title: tab.title,
                image: UIImage(systemName: tab.image),
                tag: index
            )
            return vc
        }
        
        selectedIndex = 0
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    
    /// Handles tab selection events.
    ///
    /// - Scrolls the currently visible scrollable view to top if the same tab is selected again.
    /// - Updates `lastSelectedIndex` to track current tab.
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let currentIndex = tabBarController.selectedIndex
        
        if lastSelectedIndex == currentIndex,
           let nav = viewController as? UINavigationController,
           let scrollable = nav.viewControllers.first as? Scrollable {
            scrollable.scrollToTop()
        }
        
        lastSelectedIndex = currentIndex
    }
}
