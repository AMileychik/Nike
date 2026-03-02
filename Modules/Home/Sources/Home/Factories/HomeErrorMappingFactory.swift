//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

// MARK: - HomeErrorMappingFactory
///
/// Factory responsible for creating instances of `HomeErrorMapping`.
/// Centralizes error mapping creation for the Home feature,
/// keeping the ViewModel decoupled from concrete error handling implementations.

public final class HomeErrorMappingFactory: HomeErrorMappingFactoryProtocol {

    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}

    // MARK: - Public Factory Methods
    
    /// Creates a new instance of `HomeErrorMapping`.
    ///
    /// - Returns: An instance of `HomeErrorMapper` that transforms errors into user-friendly messages.
    public func makeErrorMapper() -> HomeErrorMapping {
        HomeErrorMapper()
    }
}
