//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/30/25.
//

import Services
import AppInterface

public enum DependencyContainerFactory {
    
    public static func makeDefault() -> DependencyContainerProtocol {
        
        let networkService = NetworkService()
        let networkRepository = NetworkServiceRepository(service: networkService)
        let networkServiceUseCase = NetvorkServiceUseCase(repository: networkRepository)
        
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
