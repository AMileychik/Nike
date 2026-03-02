//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

//import UIKit
//import AppDomain
//import Coordinator
//import AppInterface
//import ShopCoordinator
//
//public final class CoordinatorFactory: CoordinatorFactoryProtocol {
//    
//    private let screenFactory: ScreenFactoryProtocol
//    private let viewModelFactory: ViewModelFactoryProtocol
//    
//    public init(screenFactory: ScreenFactoryProtocol,
//                viewModelFactory: ViewModelFactoryProtocol) {
//        self.screenFactory = screenFactory
//        self.viewModelFactory = viewModelFactory
//    }
//    
////    public func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
////        HomeCoordinator(navigationController: navigationController,
////                        screenFactory: screenFactory,
////                        coordinatorFactory: self)
////    }
//    
////    public func makeShopCoordinator(navigationController: UINavigationController) -> ShopCoordinator {
//        public func makeShopCoordinator(navigationController: UINavigationController) -> ShopCoordinatorProtocol {
//
//        ShopCoordinator(navigationController: navigationController,
//                        screenFactory: screenFactory,
//                        coordinatorFactory: self)
//    }
//    
////    public func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinator {
////        let coordinator = BagCoordinator(screenFactory: screenFactory)
////        let bagViewModel = viewModelFactory.makeBagViewModel()
////        coordinator.viewModel = bagViewModel
////        return coordinator
////    }
//    
////    public func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinatorProtocol {
////        let coordinator = BagCoordinator(screenFactory: screenFactory)
////        let bagViewModel = viewModelFactory.makeBagViewModel()
////        coordinator.viewModel = bagViewModel
////        return coordinator
////    }
//    
////    public func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinator {
////        let coordinator = BagCoordinator(screenFactory: screenFactory)
////        let bagViewModel = viewModelFactory.makeBagViewModel()
////        coordinator.viewModel = bagViewModel
////        return coordinator
////    }
// 
//    
//    
//    
//    
//    
//    
////    public func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinatorProtocol {
//////        let coordinator = BagCoordinator(viewModel: viewModelFactory, screenFactory: screenFactory)
//////        let bagViewModel = viewModelFactory.makeBagViewModel()
//////        coordinator.viewModel = bagViewModel
////        let coordinator = BagCoordinator(viewModelFactory: viewModelFactory, screenFactory: screenFactory)
////        
////        return coordinator
////        
//////        BagCoordinator(navigationController: navigationController, viewModelFactory: viewModelFactory, screenFactory: screenFactory, coordinatorFactory: self)
////    }
//    
//    
//    
//    
//    public func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinatorProtocol {
////        let coordinator = BagCoordinator(viewModelFactory: viewModelFactory, screenFactory: screenFactory)
////        let bagViewModel = viewModelFactory.makeBagViewModel()
////        coordinator.bagViewModel = bagViewModel
////        return coordinator
//        
//        BagCoordinator(viewModelFactory: viewModelFactory, screenFactory: screenFactory)
//    }
//     
////    public func makeFavoriteCoordinator(viewController: UIViewController) -> FavoriteCoordinator {
////        FavoriteCoordinator(viewController: viewController, screenFactory: screenFactory)
////    }
////    
////    public func makeDetailCoordinator(navigationController: UINavigationController) -> DetailCoordinator {
////        DetailCoordinator(navigationController: navigationController, screenFactory: screenFactory)
////    }
//
//}
