//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/30/25.
//

//import Services
//import AppInterface
//
//public enum DependencyContainerFactory {
//    
//    public static func makeDefault() -> DependencyContainerProtocol {
//        
//        let networkService = NetworkService()
//        let networkRepository = NetworkServiceRepository(service: networkService)
//        let networkServiceUseCase = NetworkServiceUseCase(repository: networkRepository)
//        
//        let bagRepository = BagUserDefaultsRepository()
//        let favoritesRepository = FavoritesUserDefaultsRepository()
//        let featureToggleRepository = FeatureToggleUserDefaultsRepository()
//        
//        return DependencyContainer(
//            networkService: networkServiceUseCase,
//            bagService: BagService(repository: bagRepository),
//            favoriteService: FavoritesService(repository: favoritesRepository),
//            featureToggleService: FeatureToggleService(repository: featureToggleRepository)
//        )
//    }
//}

import Foundation

import Services
import AppInterface

public enum DependencyContainerFactory {
    
    // MARK: - Networking
    
    public static func makeDefault(
        environment: AppEnvironment = .local
    ) -> DependencyContainerProtocol {
        
        let networkService = NetworkService()
        
        let requestBuilder = RequestBuilder(
            baseURL: environment.baseURL
        )
        
        let networkRepository = NetworkServiceRepository(
            networkService: networkService,
            requestBuilder: requestBuilder
        )
        
        let networkServiceUseCase = NetworkServiceUseCase(
            repository: networkRepository)
        
        // MARK: - Other services
        
        let bagRepository = BagUserDefaultsRepository()
        let favoritesRepository = FavoritesUserDefaultsRepository()
        let featureToggleRepository = FeatureToggleUserDefaultsRepository()
        
        return DependencyContainer(
            networkService: networkServiceUseCase,
            bagService: BagService(repository: bagRepository),
            favoriteService: FavoritesService(repository: favoritesRepository),
            featureToggleService: FeatureToggleService(repository: featureToggleRepository)
        )
    }
}
