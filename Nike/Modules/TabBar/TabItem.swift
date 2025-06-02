//
//  TabItem.swift
//  Nike
//
//  Created by Александр Милейчик on 5/29/25.
//

import UIKit

protocol Coordinator {
    func start() -> UIViewController
}

enum TabItem: CaseIterable {
    
    case shop, home, favorite, bag
    
    var title: String {
        switch self {
        case .shop: return Text.TabBarController.shop
        case .home: return Text.TabBarController.home
        case .favorite: return Text.TabBarController.favorite
        case .bag: return Text.TabBarController.bag
        }
    }
    
    var image: String {
        switch self {
        case .shop: return Images.magnifyingglass
        case .home: return Images.house
        case .favorite: return Images.heart
        case .bag: return Images.bag
        }
    }
    
    private func makeNavController(root: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: root)
    }
    
    private func makeCoordinatorTab<T: Coordinator>(
        using factory: (UINavigationController) -> T,
        onCoordinatorCreated: (Coordinator) -> Void) -> UINavigationController {
            
        let nav = UINavigationController()
        let coordinator = factory(nav)
        onCoordinatorCreated(coordinator) 
        let vc = coordinator.start()
        nav.viewControllers = [vc]
        return nav
    }

    func createViewController(
        screenFactory: ScreenFactoryProtocol,
        coordinatorFactory: CoordinatorFactoryProtocol,
        onCoordinatorCreated: @escaping (Coordinator) -> Void) -> UIViewController {
            
        switch self {
        case .home:
            return makeCoordinatorTab(
                using: coordinatorFactory.makeHomeCoordinator,
                onCoordinatorCreated: onCoordinatorCreated
            )
        case .shop:
            return makeCoordinatorTab(
                using: coordinatorFactory.makeShopCoordinator,
                onCoordinatorCreated: onCoordinatorCreated
            )
        case .favorite:
            return makeNavController(
                root: screenFactory.createFavoriteScreen()
            )
        case .bag:
            return makeNavController(
                root: screenFactory.createBagScreen()
            )
        }
    }
}
