//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/26/25.
//

import UIKit

// MARK: - HomeNavigationConfigurator

/// Configures the `UINavigationController` for the Home module.
///
/// Responsibilities include:
/// - Setting the root view controller.
/// - Adding a search button to the navigation bar and connecting its action to the `ViewBinder`.
public struct HomeNavigationConfigurator: HomeNavigationConfiguratorProtocol {
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Public API
    
    /// Configures the navigation controller with the root view controller and optional view binder.
    public func configure(
        navigationController: UINavigationController,
        rootViewController: UIViewController,
        viewBinder: ViewBinderProtocol?
    ) {
        // Set the root view controller without animation
        navigationController.setViewControllers([rootViewController], animated: false)

        // Configure the search button in the navigation bar
        configureSearchButton(navigationController: navigationController, binder: viewBinder)
    }

    // MARK: - Private Methods
    
    /// Adds a magnifying glass button to the navigation bar if a binder is provided.
    private func configureSearchButton(
        navigationController: UINavigationController,
        binder: ViewBinderProtocol?
    ) {
        guard let binder else { return }
        
        navigationController.addMagnifyButton(
            target: binder,
            action: #selector(ViewBinder.onSearchButtonTapped)
        )
    }
}
