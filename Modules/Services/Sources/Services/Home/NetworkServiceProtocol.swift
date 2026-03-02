//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/5/26.
//

import Foundation

import AppDomain

// MARK: - NetworkServiceProtocol

/// Defines a protocol for executing network requests.
public protocol NetworkServiceProtocol {
    /// Executes a request and decodes the response into a Decodable type.
    ///
    /// - Parameter request: The URLRequest to execute.
    /// - Returns: A decoded object of type `T`.
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
}
