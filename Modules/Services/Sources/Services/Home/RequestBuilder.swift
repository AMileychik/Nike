//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/4/26.
//


import Foundation
import AppInterface

// MARK: - RequestBuilding

/// Protocol for building URLRequests for specific endpoints.
///
/// Acts as a factory for creating `URLRequest` objects based on the app's `Endpoint` enum.
public protocol RequestBuilding {
    
    /// Creates a URLRequest for a given endpoint.
    ///
    /// - Parameter endpoint: The endpoint for which to create the request.
    /// - Throws: `NetworkError.invalidURL` if the URL cannot be constructed.
    /// - Returns: A configured `URLRequest` ready to be executed.
    func makeRequest(for endpoint: Endpoint) throws -> URLRequest
}

// MARK: - RequestBuilder

/// Concrete implementation of `RequestBuilding`.
///
/// Responsible for constructing URLRequests using a base URL and an `Endpoint`.
public final class RequestBuilder: RequestBuilding {
    
    // MARK: - Properties
    
    /// Base URL used as the root for all endpoint paths.
    private let baseURL: URL
    
    // MARK: - Initialization
    
    /// Initializes the builder with a base URL.
    ///
    /// - Parameter baseURL: The root URL for all requests.
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: - RequestBuilding
    
    /// Builds a URLRequest for a given endpoint.
    ///
    /// - Parameter endpoint: The API endpoint to request.
    /// - Throws: `NetworkError.invalidURL` if the URL cannot be constructed.
    /// - Returns: A fully configured `URLRequest` with HTTP method and timeout.
    public func makeRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 30
        return request
    }
}

//import Foundation
//
//import AppInterface
//
//public protocol RequestBuilding {
//    func makeRequest(for endpoint: Endpoint) throws -> URLRequest
//}
//
//public final class RequestBuilder: RequestBuilding {
//    
//    private let baseURL: URL
//    
//    public init(baseURL: URL) {
//        self.baseURL = baseURL
//    }
//    
//    public func makeRequest(for endpoint: Endpoint) throws -> URLRequest {
//        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
//            throw NetworkError.invalidURL
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.method.rawValue
//        request.timeoutInterval = 30
//        return request
//    }
//}
