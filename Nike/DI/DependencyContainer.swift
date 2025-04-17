//
//  DependencyContainer.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/15/24.
//

import Foundation

final class DependencyContainer {
    
    let session: URLSession
    let decoder: JSONDecoder
    let loader: NetworkService
    let screenFactory: ScreenFactory
    
    init() {
        session = URLSession.shared
        decoder = JSONDecoder()
        loader = NetworkService(session: session, decoder: decoder)
        screenFactory = ScreenFactory()
        screenFactory.dependencyContainer = self
    }
}

//MARK: - ScreenFactory
final class ScreenFactory {
    
    weak var dependencyContainer: DependencyContainer!
    
    func createHomeScreen() -> HomeViewController {
        let homeViewModel = HomeViewModel(homeLoader: dependencyContainer.loader)
        return HomeViewController(homeViewModel: homeViewModel)
    }
    
    func createShopScreen() -> ShopViewController  {
        let presenter = ShopPresenter(shopLoader: dependencyContainer.loader)
        return ShopViewController (presenter: presenter)
    }
    
    func createFavoriteScreen() -> FavoritesViewController {
        return FavoritesViewController()
    }
    
    func createBagScreen() -> BagViewController  {
        return BagViewController()
    }
    
    func createDetailScreen() -> DetailViewController  {
        return DetailViewController()
    }
    
    func createComingSoonScreen() -> ComingSoonViewController {
        return ComingSoonViewController()
    }
}
