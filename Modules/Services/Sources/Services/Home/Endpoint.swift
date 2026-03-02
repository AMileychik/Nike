//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/5/26.
//

import Foundation

import AppDomain

// MARK: - Endpoint

/// Represents API endpoints used in the app.
public enum Endpoint {
    case home
    case shop
}

/// Supported HTTP methods.
public enum HTTPMethod: String {
    case get = "GET"
}

public extension Endpoint {
    
    /// Returns the path component of the endpoint.
    var path: String {
        switch self {
        case .home: return "/home"
        case .shop: return "/shop"
        }
    }
    
    /// Returns the HTTP method for the endpoint.
    var method: HTTPMethod {
        .get
    }
}
