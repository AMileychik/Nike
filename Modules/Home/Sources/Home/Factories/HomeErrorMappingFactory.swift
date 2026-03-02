//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

/// Factory for creating instances of `HomeErrorMapping`.
public final class HomeErrorMappingFactory: HomeErrorMappingFactoryProtocol {

    /// Default initializer.
    public init() {}

    /// Creates a new instance of `HomeErrorMapping`.
    /// - Returns: A `HomeErrorMapper` instance.
    public func makeErrorMapper() -> HomeErrorMapping {
        HomeErrorMapper()
    }
}
