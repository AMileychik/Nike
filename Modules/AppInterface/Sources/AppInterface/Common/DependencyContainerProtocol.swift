//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/30/25.
//

import Foundation

public protocol HasNetworkService {
    var networkService: NetworkServiceUseCaseProtocol {get}
}

public protocol HasBagService {
    var bagService: BagServiceProtocol { get }
}

public protocol HasFavoriteService {
    var favoriteService: FavoritesServiceProtocol { get }
}

public protocol HasFeatureToggleService {
    var featureToggleService: FeatureToggleServiceProtocol { get }
}

public typealias DependencyContainerProtocol = HasNetworkService & HasBagService & HasFavoriteService & HasFeatureToggleService



