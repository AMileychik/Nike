//
//  ScreenFactory.swift
//  Nike
//
//  Created by Александр Милейчик on 5/28/25.
//

import Foundation

protocol ScreenFactoryProtocol: AnyObject {
    func createHomeScreen() -> HomeViewController
    func createShopScreen() -> ShopViewController
    func createFavoriteScreen() -> FavoritesViewController
    func createBagScreen() -> BagViewController
    func createDetailScreen() -> DetailViewController
    func createComingSoonScreen() -> ComingSoonViewController
    func createErrorScreen(message: String) -> ErrorViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
 
    // MARK: - Dependencies
    private let viewModelFactory: ViewModelFactoryProtocol
    private let presenterFactory: ShopPresenterFactoryProtocol
    
    // MARK: - Init
    init(viewModelFactory: ViewModelFactoryProtocol, 
         presenterFactory: ShopPresenterFactoryProtocol)
    {
        self.viewModelFactory = viewModelFactory
        self.presenterFactory = presenterFactory
    }

    // MARK: - Screens
    func createHomeScreen() -> HomeViewController {
        let viewModel = viewModelFactory.makeHomeViewModel()
        return HomeViewController(homeViewModel: viewModel)
    }

    func createShopScreen() -> ShopViewController  {
        let presenter = presenterFactory.makeShopPresenter()
        return ShopViewController(presenter: presenter)
    }

    func createFavoriteScreen() -> FavoritesViewController {
        return FavoritesViewController()
    }

    func createBagScreen() -> BagViewController  {
        return BagViewController()
    }

    func createDetailScreen() -> DetailViewController  {
        let viewModel = viewModelFactory.makeDetailViewModel()
        return DetailViewController(viewModel: viewModel)
    }

    func createComingSoonScreen() -> ComingSoonViewController {
        return ComingSoonViewController()
    }
    
    func createErrorScreen(message: String) -> ErrorViewController {
        return ErrorViewController(message: message)
    }
}
