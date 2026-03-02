//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/5/26.
//

import Foundation

import AppDomain

// MARK: - AppEnvironment

/// Defines the app's network environment (base URL, etc.).
public enum AppEnvironment {
    case local
    
    /// Returns the base URL for the environment.
    public var baseURL: URL {
        switch self {
        case .local:
            return URL(string: "http://localhost:3001")!
        }
    }
}
