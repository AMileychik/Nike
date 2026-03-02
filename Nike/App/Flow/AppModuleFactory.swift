//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import AppCore

// MARK: - AppModuleFactory

/// Factory responsible for creating the root flow of the application.
///
/// Encapsulates the app configuration and flow coordinator,
/// providing a single entry point to obtain the root flow.
public final class AppModuleFactory: ModuleFactoryProtocol {
    
    // MARK: - Dependencies
    
    /// The app configuration containing flow type and feature flags.
    private let config: AppConfiguration
    
    /// Factory for creating flow coordinators based on dependencies.
    private let flowFactory: FlowCoordinatorFactoryProtocol

    // MARK: - Initialization
    
    /// Initializes the module factory with configuration and flow factory.
    ///
    /// - Parameters:
    ///   - config: The app configuration containing flow type and feature flags.
    ///   - flowFactory: Factory that produces flow coordinators.
    public init(config: AppConfiguration, flowFactory: FlowCoordinatorFactoryProtocol) {
        self.config = config
        self.flowFactory = flowFactory
    }

    // MARK: - Public API
    
    /// Creates the root flow factory for the application.
    ///
    /// - Returns: A `RootFlowFactoryProtocol` configured for the app's root flow.
    public func makeRootFlow() -> RootFlowFactoryProtocol {
        return flowFactory.makeRootFlow(flowType: config.flowType, config: config)
    }
}

