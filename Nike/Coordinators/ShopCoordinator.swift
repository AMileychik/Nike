//
//  ShopCoordinator.swift
//  Nike
//
//  Created by Александр Милейчик on 5/31/25.
//

import UIKit

final class ShopCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol)
    {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    // MARK: - Start
    func start() -> UIViewController {
        let viewController = screenFactory.createShopScreen()
        viewController.shopCoordinator = self
        return viewController
    }
    
    // MARK: - Navigation Helpers
    private func pushDetailScreen(configure: (DetailViewController) -> Void) {
        let detailViewController = screenFactory.createDetailScreen()
        configure(detailViewController)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Shop Detail Sections
    func navigateToShopDetailSections(with product: Product) {
        pushDetailScreen { detailViewController in
            detailViewController.updasteShopDetailSections(model: [product])
        }
    }
    
    // MARK: - Shop List Dedail Sections
    func navigateToShopListDetailSections(with product: Product) {
        pushDetailScreen { detailViewController in
            detailViewController.updateShopListDetailSections(model: [product])
        }
    }
}


