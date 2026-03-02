//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

//import UIKit
//import AppDomain
//import ViewModel
//import AppInterface
//import SharedUI
//import ShopUI
//
//public final class ScreenFactory: ScreenFactoryProtocol {
//    
////    private let container: DependencyContainerProtocol
//    private let viewModelFactory: ViewModelFactoryProtocol
//    private let presenterFactory: ShopPresenterFactoryProtocol
//    private let uiComponentsFactory: UIComponentsFactoryProtocol
//    
//    public init(
//        //container: DependencyContainerProtocol,
//                viewModelFactory: ViewModelFactoryProtocol,
//                presenterFactory: ShopPresenterFactoryProtocol,
//                uiComponentsFactory: UIComponentsFactoryProtocol)
//    {
//   //     self.container = container
//        self.viewModelFactory = viewModelFactory
//        self.presenterFactory = presenterFactory
//        self.uiComponentsFactory = uiComponentsFactory
//    }
//    
//    //    public func createHomeScreen() -> UIViewController {
//    //        let viewModel = viewModelFactory.makeHomeViewModel()
////        return HomeViewController(homeViewModel: viewModel)
////    }
////
//    public func createShopScreen() -> UIViewController {
//        let presenter = presenterFactory.makeShopPresenter()
//        return ShopViewController(presenter: presenter)
//    }
////
////    public func createFavoriteScreen() -> UIViewController {
////        let viewModel = viewModelFactory.makeFavoriteViewModel()
////        return FavoritesViewController(viewModel: viewModel)
////    }
//    
////    public func createBagScreen(viewModel: BagViewModelProtocol) -> UIViewController {
////        let tableView = BagTableView(viewModel: viewModel)
////        let buttonsView = uiComponentsFactory.makeBagButtonsView(types: [BagButtonType.pay, BagButtonType.checkout])
////        
////        let bagVC = BagViewController(viewModel: viewModel, bagTableView: tableView, buttonsView: buttonsView)
////        return bagVC
////    }
//    
////    public func createDetailScreen() -> UIViewController {
////        let viewModel = viewModelFactory.makeDetailViewModel()
////        return DetailViewController(viewModel: viewModel)
////    }
////
//    public func createComingSoonScreen() -> UIViewController {
//        return ComingSoonViewController()
//    }
////    
////    public func createErrorScreen(message: String) -> UIViewController {
////        return ErrorViewController(message: message)
////    }
////    
////    public func createQuantityPickerViewController() -> UIViewController {
////        return QuantityPickerViewController()
////    }
//}
