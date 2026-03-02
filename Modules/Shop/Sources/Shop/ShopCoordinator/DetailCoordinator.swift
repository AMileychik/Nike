//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

//import UIKit
//import AppInterface
//
//public protocol DetailCoordinatorProtocol: AnyObject {
//    func navigateToCommingSoonViewController()
//}
//
//public final class DetailCoordinator: DetailCoordinatorProtocol {
//    
//    // MARK: - Properties
//    public let navigationController: UINavigationController
//    private let screenFactory: ScreenFactoryProtocol
//    
//    public var onFinish: (() -> Void)?
//    
//    // MARK: - Init
//    public init(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol) {
//        self.navigationController = navigationController
//        self.screenFactory = screenFactory
//    }
//    
//    // MARK: - Navigation
//    public func navigateToCommingSoonViewController() {
//        let viewController = screenFactory.createComingSoonScreen()
//        navigationController.pushViewController(viewController, animated: true)
//    }
//    
////    public func makeDetailViewController(configure: (DetailViewController) -> Void) -> DetailViewController {
////        let detailVC = screenFactory.createDetailScreen()
////        detailVC.detailRouter = self
////        configure(detailVC)
////        return detailVC
////    }
//    
//    public func detailDidFinish() {
//        onFinish?()
//    }
//}
