//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

//import UIKit
//
//public protocol HomeRouterProtocol: AnyObject {
//    func showDetail(data: DetailData)
//    func showComingSoon(from viewController: UIViewController)
//}
//
//public final class HomeCoordinator: CoordinatorProtocol, HomeRouterProtocol {
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
//        let viewController = screenFactory.createHomeScreen()
//        viewController.homeRouter = self
//        return viewController
//    }
//    
//    // MARK: - DetailVC
//    public func showDetail(data: DetailData) {
//        pushDetailScreen { detailVC in
//            detailVC.updateContent(with: data)
//        }
//    }
//    
//    // MARK: - Coming Soon
//    public func showComingSoon(from viewController: UIViewController) {
//        let comingSoonVC = screenFactory.createComingSoonScreen()
//        comingSoonVC.modalPresentationStyle = .fullScreen
//        viewController.present(comingSoonVC, animated: true)
//    }
//    
//    private func pushDetailScreen(configure: (DetailViewController) -> Void) {
//        let coordinator = coordinatorFactory.makeDetailCoordinator(navigationController: navigationController)
//        coordinator.onFinish = { [weak self] in
//            self?.detailCoordinator = nil
//        }
//        self.detailCoordinator = coordinator
//        let detailVC = coordinator.makeDetailViewController(configure: configure)
//        navigationController.pushViewController(detailVC, animated: true)
//    }
//}
