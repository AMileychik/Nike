//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import Foundation
import AppDomain
import AppInterface

// MARK: - NetworkServiceRepository

/// Repository responsible for fetching network data for the app.
///
/// Acts as a layer between the raw `NetworkServiceProtocol` and domain-specific models.
/// Handles request creation via `RequestBuilding` and executes requests using `NetworkServiceProtocol`.
public final class NetworkServiceRepository: NetworkServiceRepositoryProtocol {
    
    // MARK: - Dependencies
    
    /// The network service used to perform requests.
    private let networkService: NetworkServiceProtocol
    
    /// Builds URLRequests for specific endpoints.
    private let requestBuilder: RequestBuilding
    
    // MARK: - Initialization
    
    /// Initializes the repository with required dependencies.
    ///
    /// - Parameters:
    ///   - networkService: Service that executes network requests.
    ///   - requestBuilder: Factory for creating URLRequests.
    public init(
        networkService: NetworkServiceProtocol,
        requestBuilder: RequestBuilding
    ) {
        self.networkService = networkService
        self.requestBuilder = requestBuilder
    }
    
    // MARK: - Public Methods
    
    /// Loads data for the Home screen.
    ///
    /// - Throws: `NetworkError` if the request fails, server returns error, or decoding fails.
    /// - Returns: A decoded `HomeSectionsResponse` object.
    public func loadHomeData() async throws -> HomeSectionsResponse {
        let request = try requestBuilder.makeRequest(for: .home)
        return try await networkService.execute(request)
    }
    
    /// Loads data for the Shop screen.
    ///
    /// - Throws: `NetworkError` if the request fails, server returns error, or decoding fails.
    /// - Returns: A decoded `ShopSectionsResponse` object.
    public func loadShopData() async throws -> ShopSectionsResponse {
        let request = try requestBuilder.makeRequest(for: .shop)
        return try await networkService.execute(request)
    }
}




//import Foundation
//
//import AppDomain
//import AppInterface
//
//public final class NetworkServiceRepository: NetworkServiceRepositoryProtocol {
//    
//    private let networkService: NetworkServiceProtocol
//    private let requestBuilder: RequestBuilding
//    
//    public init(
//        networkService: NetworkServiceProtocol,
//        requestBuilder: RequestBuilding
//    ) {
//        self.networkService = networkService
//        self.requestBuilder = requestBuilder
//    }
//    
//    public func loadHomeData() async throws -> HomeSectionsResponse {
//        let request = try requestBuilder.makeRequest(for: .home)
//        return try await networkService.execute(request)
//    }
//    
//    public func loadShopData() async throws -> ShopSectionsResponse {
//        let request = try requestBuilder.makeRequest(for: .shop)
//        return try await networkService.execute(request)
//    }
//}
