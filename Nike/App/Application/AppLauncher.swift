//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import UIKit
import AppCore

// MARK: - AppLauncher

/// A centralized entry point for launching the application.
///
/// Responsibilities:
/// - Configures the app based on the selected `RootFlowType`.
/// - Initializes all required dependencies, factories, and coordinators.
/// - Starts the app's root coordinator to present the initial UI.
public struct AppLauncher {
    
    // MARK: - Public API
    
    /// Starts the application in the provided window with the specified dependencies and flow type.
    ///
    /// - Parameters:
    ///   - window: The main `UIWindow` where the app UI will be displayed.
    ///   - dependencies: Provides app-wide services and dependencies conforming to `AppDependenciesProtocol`.
    ///   - flowType: The root flow type determining which initial flow to launch.
    public static func startApp(
        in window: UIWindow,
        dependencies: AppDependenciesProtocol,
        flowType: RootFlowType
    ) {
        // MARK: - App Configuration
        // Build the configuration for the app based on feature toggles and flow type
        let config = AppConfigurationFactory.make(
            flowType: flowType,
            featureService: dependencies.container.featureToggleService
        )
        
        // MARK: - Flow and Module Factories
        // Initialize the flow coordinator factory with dependencies
        let flowFactory = FlowCoordinatorFactory(dependencies: dependencies)
        
        // Create the module factory responsible for building the app's flows and view controllers
        let moduleFactory = AppModuleFactory(config: config, flowFactory: flowFactory)
        
        // MARK: - App Coordinator
        // Initialize the app coordinator with the window and root flow
        let coordinator = AppCoordinator(
            window: window,
            rootFactory: moduleFactory.makeRootFlow()
        )
        
        // Start the app's root coordinator to present the initial UI
        coordinator.start()
    }
}

