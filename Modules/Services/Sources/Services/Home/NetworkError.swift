//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/5/26.
//

import Foundation

import AppDomain

// MARK: - NetworkError

/// Represents all possible errors that can occur during a network request.
public enum NetworkError: Error {
    /// The URL was invalid.
    case invalidURL
    
    /// A transport-level error occurred (e.g., connectivity issues).
    case transport(Error)
    
    /// Server returned a non-2xx response.
    /// - Parameters:
    ///   - statusCode: The HTTP status code.
    ///   - payload: Optional response body from the server.
    case server(statusCode: Int, payload: Data?)
    
    /// Failed to decode the server response.
    case decoding(Error)
}
