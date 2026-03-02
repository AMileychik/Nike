//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import UIKit

//public protocol FavoriteCoordinatorProtocol: AnyObject {
//    func navigateToComingSoonViewController()
//}
//
//public final class FavoriteCoordinator: CoordinatorProtocol, FavoriteCoordinatorProtocol {
//    
//    // MARK: - Properties
//    private let viewController: UIViewController
//    private let screenFactory: ScreenFactoryProtocol
//    
//    // MARK: - Init
//    public init(viewController: UIViewController, screenFactory: ScreenFactoryProtocol) {
//        self.viewController = viewController
//        self.screenFactory = screenFactory
//    }
//    
//    // MARK: - Start
//    public func start() -> UIViewController {
//        let viewController = screenFactory.createFavoriteScreen()
//        viewController.router = self
//        return viewController
//    }
//    
//    // MARK: - Navigation
//    public func navigateToComingSoonViewController() {
//        let comingSoonViewController = screenFactory.createComingSoonScreen()
//        comingSoonViewController.modalPresentationStyle = .fullScreen
//        viewController.present(comingSoonViewController, animated: true)
//    }
//}
