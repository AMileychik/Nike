//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation

import AppDomain

// MARK: - NetworkService

/// Concrete implementation of `NetworkServiceProtocol`.
///
/// Handles network requests using `URLSession` and decodes JSON responses.
/// Converts transport, server, and decoding errors into `NetworkError`.
public final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Dependencies
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Initialization
    
    /// Initializes a network service with optional timeout and decoder.
    ///
    /// - Parameters:
    ///   - timeout: Timeout interval for requests (default 30s).
    ///   - decoder: JSON decoder to use (default `JSONDecoder`).
    public init(
        timeout: TimeInterval = 30,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeout
        config.timeoutIntervalForResource = timeout
        self.session = URLSession(configuration: config)
        self.decoder = decoder
    }
    
    // MARK: - Execution
    
    /// Executes a URLRequest and decodes the response into a Decodable type.
    ///
    /// - Parameter request: The request to execute.
    /// - Throws: `NetworkError` if transport fails, server returns error, or decoding fails.
    /// - Returns: A decoded object of type `T`.
    public func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            // Perform the network request
            let (data, response) = try await session.data(for: request)
            
            // Ensure we received an HTTPURLResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.server(statusCode: -1, payload: data)
            }
            
            // Validate HTTP status code
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.server(statusCode: httpResponse.statusCode, payload: data)
            }
            
            // Decode the response
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }
            
        } catch {
            // Wrap transport errors
            throw NetworkError.transport(error)
        }
    }
}

//import Foundation
//
//import AppDomain
//
//public enum NetworkError: Error {
//    case invalidURL
//    case transport(Error)
//    case server(statusCode: Int, payload: Data?)
//    case decoding(Error)
//}
//
//// MARK: - Endpoint
//
//public enum Endpoint {
//    case home
//    case shop
//}
//
//public enum HTTPMethod: String {
//    case get = "GET"
//}
//
//public extension Endpoint {
//    
//    var path: String {
//        switch self {
//        case .home:
//            return "/home"
//        case .shop:
//            return "/shop"
//        }
//    }
//    
//    var method: HTTPMethod {
//        .get
//    }
//}
//
//public enum AppEnvironment {
//    case local
//    
//    public var baseURL: URL {
//        switch self {
//        case .local:
//            return URL(string: "http://localhost:3001")!
//        }
//    }
//}
//
//public protocol NetworkServiceProtocol {
//    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
//}
//
//public final class NetworkService: NetworkServiceProtocol {
//    
//    private let session: URLSession
//    private let decoder: JSONDecoder
//    
//    public init(
//        timeout: TimeInterval = 30,
//        decoder: JSONDecoder = JSONDecoder()
//    ) {
//        let config = URLSessionConfiguration.default
//        config.timeoutIntervalForRequest = timeout
//        config.timeoutIntervalForResource = timeout
//        self.session = URLSession(configuration: config)
//        self.decoder = decoder
//    }
//    
//    public func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
//        do {
//            let (data, response) = try await session.data(for: request)
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                throw NetworkError.server(statusCode: -1, payload: data)
//            }
//            
//            guard (200..<300).contains(httpResponse.statusCode) else {
//                throw NetworkError.server(
//                    statusCode: httpResponse.statusCode,
//                    payload: data
//                )
//            }
//            
//            do {
//                return try decoder.decode(T.self, from: data)
//            } catch {
//                throw NetworkError.decoding(error)
//            }
//            
//        } catch {
//            throw NetworkError.transport(error)
//        }
//    }
//}
