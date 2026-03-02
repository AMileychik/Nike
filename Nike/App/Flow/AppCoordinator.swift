//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppCore

// MARK: - AppCoordinator

/// Coordinates the root flow of the application.
///
/// Responsible for setting up the root view controller
/// provided by a `RootFlowFactoryProtocol` and making the
/// main window key and visible.
public final class AppCoordinator {
    
    // MARK: - Properties
    
    /// The main application window.
    private let window: UIWindow
    
    /// Factory that provides the root flow's view controller.
    private let rootFactory: RootFlowFactoryProtocol

    // MARK: - Initialization
    
    /// Initializes the coordinator with the main window and a root flow factory.
    ///
    /// - Parameters:
    ///   - window: The application's main window.
    ///   - rootFactory: Factory responsible for creating the root flow.
    public init(window: UIWindow, rootFactory: RootFlowFactoryProtocol) {
        self.window = window
        self.rootFactory = rootFactory
    }

    // MARK: - Public API
    
    /// Starts the application by setting the root view controller
    /// and making the window key and visible.
    public func start() {
        let rootVC = rootFactory.makeRootViewController()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
}

