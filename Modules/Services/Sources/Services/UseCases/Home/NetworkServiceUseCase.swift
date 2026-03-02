//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//


import AppDomain
import AppInterface

// MARK: - NetworkServiceUseCase

/// Use case responsible for fetching home data from the network.
///
/// Acts as a higher-level abstraction over `NetworkServiceRepositoryProtocol`.
/// It executes network requests and returns the parsed `HomeSectionsResponse`.
public final class NetworkServiceUseCase: NetworkServiceUseCaseProtocol {
    
    // MARK: - Dependencies
    
    /// Repository responsible for executing network requests.
    private let repository: NetworkServiceRepositoryProtocol
    
    // MARK: - Initialization
    
    /// Initializes the use case with a repository.
    ///
    /// - Parameter repository: Provides network access for Home data.
    public init(repository: NetworkServiceRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Public API
    
    /// Executes the use case to fetch Home sections.
    ///
    /// - Returns: `HomeSectionsResponse` containing all data for the Home screen.
    /// - Throws: Propagates any network or decoding errors from the repository.
    public func execute() async throws -> HomeSectionsResponse {
        try await repository.loadHomeData()
    }
}


//import AppDomain
//
//import AppInterface
//
//public final class NetworkServiceUseCase: NetworkServiceUseCaseProtocol {
//
//    private let repository: NetworkServiceRepositoryProtocol
//
//    public init(repository: NetworkServiceRepositoryProtocol) {
//        self.repository = repository
//    }
//
//    public func execute() async throws -> HomeSectionsResponse {
//        try await repository.loadHomeData()
//    }
//}
