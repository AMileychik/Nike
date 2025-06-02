//
//  CoordinatorFactory.swift
//  Nike
//
//  Created by Александр Милейчик on 5/30/25.
//

import UIKit

protocol CoordinatorFactoryProtocol: AnyObject {
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator
    func makeShopCoordinator(navigationController: UINavigationController) -> ShopCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let screenFactory: ScreenFactoryProtocol
    
    init(screenFactory: ScreenFactoryProtocol){
        self.screenFactory = screenFactory
    }
    
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
        return HomeCoordinator(navigationController: navigationController, screenFactory: screenFactory)
    }
    
    func makeShopCoordinator(navigationController: UINavigationController) -> ShopCoordinator {
        return ShopCoordinator(navigationController: navigationController, screenFactory: screenFactory)
    }
}
