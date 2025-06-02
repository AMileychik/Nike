//
//  HomeCoordinator.swift
//  Nike
//
//  Created by Александр Милейчик on 5/29/25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController,
         screenFactory: ScreenFactoryProtocol)
    {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    // MARK: - Start
    func start() -> UIViewController {
        let viewController = screenFactory.createHomeScreen()
        viewController.homeCoordinator = self
        return viewController
    }
    
    // MARK: - Navigation Helpers
    private func pushDetailScreen(configure: (DetailViewController) -> Void) {
        let detailViewController = screenFactory.createDetailScreen()
        configure(detailViewController)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func showErrorScreen(message: String) {
        let errorVC = screenFactory.createErrorScreen(message: message)
        navigationController.pushViewController(errorVC, animated: true)
    }
    
    // MARK: - Product Detail
    func showProductDetail(model: TopPickSelection) {
        guard
            model.categories != nil,
            model.header != nil,
            model.subCategory != nil
        else {
            showErrorScreen(message: "Required data is nil")
            return
        }
        
        pushDetailScreen { detailViewController in
            detailViewController.updateProductDetailSections(
                model: model)
        }
    }
    
    // MARK: - Promo
    func showPromoDetail(model: [Product]) {
        pushDetailScreen { detailViewController in
            detailViewController.updatePromoDetailSections(model: model)
        }
    }
    
    // MARK: - New From Nike
    func showNewFromNikeDetail(model: [NewFromNikeModel]) {
        pushDetailScreen { detailViewController in
            detailViewController.updateNewFromNikeDetailSections(model: model)
        }
    }
    
    func showNewFromNikeVerticalDetail(model: [NewFromNikeModel]) {
        pushDetailScreen { detailViewController in
            detailViewController.updateVerticalNewFromNikeDetailSections(model: model)
        }
    }
    
    // MARK: - Stories
    func showStoriesForYouDetail(model: [StoriesForYou]) {
        pushDetailScreen { detailViewController in
            detailViewController.updateStoriesForYouDetailSections(model: model)
        }
    }
    
    // MARK: - Coming Soon
    func showComingSoon(from viewController: UIViewController) {
        let comingSoonVC = screenFactory.createComingSoonScreen()
        comingSoonVC.modalPresentationStyle = .fullScreen
        viewController.present(comingSoonVC, animated: true)
    }
}
