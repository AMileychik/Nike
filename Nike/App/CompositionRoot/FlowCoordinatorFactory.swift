//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import AppCore

// MARK: - FlowCoordinatorFactory

/// Factory responsible for creating root flows for the application.
///
/// Delegates the creation of specific root flows (e.g., tab bar flow)
/// based on the `RootFlowType` and configuration provided.
public final class FlowCoordinatorFactory: FlowCoordinatorFactoryProtocol {
    
    // MARK: - Dependencies
    
    /// App-wide dependencies used to create feature modules and UI components.
    private let dependencies: AppDependenciesProtocol
    
    // MARK: - Initialization
    
    /// Initializes the factory with app dependencies.
    ///
    /// - Parameter dependencies: Provides access to feature modules and UI factories.
    public init(dependencies: AppDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - Factory Method
    
    /// Creates a root flow factory based on the given flow type and configuration.
    ///
    /// - Parameters:
    ///   - flowType: The type of root flow to create (e.g., tab bar).
    ///   - config: App configuration including feature flags.
    /// - Returns: A root flow factory conforming to `RootFlowFactoryProtocol`.
    public func makeRootFlow(flowType: RootFlowType, config: AppConfiguration) -> RootFlowFactoryProtocol {
        switch flowType {
        case .tabBar:
            return TabBarRootFactory(
                dependencies: dependencies,
                configuration: config
            )
        }
    }
}
