//
//  DependencyContainer.swift
//  Nike
//
//  Created by Александр Милейчик on 11/15/24.
//

import Foundation

protocol DependencyContainerProtocol {
    var networkService: NetworkServiceProtocol { get }
}

final class DependencyContainer: DependencyContainerProtocol {
    
    // MARK: - Services
    let networkService: NetworkServiceProtocol
    
    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension DependencyContainer {
    
    // MARK: - Production Configuration
    static func makeDefault() -> DependencyContainer {
        DependencyContainer(
            networkService: NetworkService()
        )
    }
}
