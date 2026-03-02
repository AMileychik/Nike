//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

//import UIKit
//import AppInterface
//import AppDomain
//
////public protocol ShopCoordinatorProtocol: AnyObject, CoordinatorProtocol {
////  //  func showDetail(data: DetailData)
////}
//
//public final class ShopCoordinator: ShopCoordinatorProtocol {
//    
//    // MARK: - Properties
//    private let navigationController: UINavigationController
//    private let screenFactory: ScreenFactoryProtocol
//    private let coordinatorFactory: CoordinatorFactoryProtocol
//    private var detailCoordinator: DetailCoordinator?
//    
//    // MARK: - Init
//    public init(navigationController: UINavigationController,
//                screenFactory: ScreenFactoryProtocol,
//                coordinatorFactory: CoordinatorFactoryProtocol)
//    {
//        self.navigationController = navigationController
//        self.screenFactory = screenFactory
//        self.coordinatorFactory = coordinatorFactory
//    }
//    
//    // MARK: - Start
//    public func start() -> UIViewController {
//        let viewController = screenFactory.createShopScreen()
//       // viewController.shopRouter = self
//        if let shopRoutableVC = viewController as? ShopRoutableProtocol {
//            shopRoutableVC.shopRouter = self
//        } else {
//            assertionFailure("Expected viewController to conform to ShopRoutableProtocol")
//        }
//        
//        return viewController
//    }
//    
//    // MARK: - Navigation Helpers
////    private func pushDetailScreen(configure: (DetailViewController) -> Void) {
////        let coordinator = coordinatorFactory.makeDetailCoordinator(navigationController: navigationController)
////        coordinator.onFinish = { [weak self] in
////            self?.detailCoordinator = nil
////        }
////        self.detailCoordinator = coordinator
////        let detailVC = coordinator.makeDetailViewController(configure: configure)
////        navigationController.pushViewController(detailVC, animated: true)
////    }
//    
//    // MARK: - Shop Detail Sections
////    public func showDetail(data: DetailData) {
////        pushDetailScreen { detailVC in
////            detailVC.updateContent(with: data)
////        }
////    }
//}
