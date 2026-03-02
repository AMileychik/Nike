//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppCore

// MARK: - TabBarRootFactory

/// Factory responsible for creating the root tab bar flow of the application.
///
/// Encapsulates dependencies and app configuration, providing a single entry point
/// to obtain the `MainTabBarController`.
public final class TabBarRootFactory: RootFlowFactoryProtocol {
    
    // MARK: - Dependencies
    
    /// App-wide dependencies including feature modules and UI factories.
    private let dependencies: AppDependenciesProtocol
    
    /// App configuration containing flow type and feature flags.
    private let configuration: AppConfiguration
    
    // MARK: - Initialization
    
    /// Initializes the root tab bar factory with dependencies and configuration.
    ///
    /// - Parameters:
    ///   - dependencies: App-wide dependencies container.
    ///   - configuration: App configuration containing flow type and feature flags.
    public init(dependencies: AppDependenciesProtocol, configuration: AppConfiguration) {
        self.dependencies = dependencies
        self.configuration = configuration
    }
    
    // MARK: - RootFlowFactoryProtocol
    
    /// Creates the main tab bar controller configured with dependencies and app configuration.
    ///
    /// - Returns: A fully configured `MainTabBarController` as the root view controller.
    public func makeRootViewController() -> UIViewController {
        return MainTabBarController(
            dependencies: dependencies,
            configuration: configuration
        )
    }
}
