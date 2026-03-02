//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import AppInterface

public final class DependencyContainer: DependencyContainerProtocol {    
    
    // use useCases fo all others services
    public let networkService: NetworkServiceUseCaseProtocol
    public let bagService: BagServiceProtocol
    public let favoriteService: FavoritesServiceProtocol
    public let featureToggleService: FeatureToggleServiceProtocol
    
    public init(
        networkService: NetworkServiceUseCaseProtocol,
        bagService: BagServiceProtocol,
        favoriteService: FavoritesServiceProtocol,
        featureToggleService: FeatureToggleServiceProtocol)
    {
        self.networkService = networkService
        self.bagService = bagService
        self.favoriteService = favoriteService
        self.featureToggleService = featureToggleService
    }
}


