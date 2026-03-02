//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/24/25.
//

import Foundation

// MARK: - HomeErrorMapper

/// Maps generic errors into `HomeError` values suitable for the Home feature.
///
/// Responsibilities:
/// - Converts networking errors (`URLError`) into `.network`.
/// - Maps all other errors to `.unknown` for generic handling.
public struct HomeErrorMapper: HomeErrorMapping {
    
    // MARK: - Public API
    
    /// Maps a generic `Error` to a `HomeError`.
    ///
    /// - Parameter error: The error to map.
    /// - Returns: Corresponding `HomeError` for UI or logic handling.
    public func map(_ error: Error) -> HomeError {
        switch error {
        case is URLError:
            return .network
        default:
            return .unknown
        }
    }
}

