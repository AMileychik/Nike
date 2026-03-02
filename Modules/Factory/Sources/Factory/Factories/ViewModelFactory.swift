//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//
//import Foundation
//import ViewModel
//import AppInterface
//
//public final class ViewModelFactory: ViewModelFactoryProtocol {
//
//    private let container: DependencyContainerProtocol
//    
//    public init(container: DependencyContainerProtocol) {
//        self.container = container
//    }
//    
////    public func makeHomeViewModel() -> HomeViewModel {
////        HomeViewModel(homeLoader: container.networkService)
////    }
////    
////    public func makeDetailViewModel() -> DetailViewModel {
////        DetailViewModel(bagService: container.bagService, favoritesService: container.favoriteService)
////    }
////    
////    public func makeFavoriteViewModel() -> FavoriteViewModel {
////        FavoriteViewModel(favoriteService: container.favoriteService)
////    }
//    
////    public func makeBagViewModel() -> BagViewModel {
////        let useCase = BagUseCaseImpl(
////            bagService: container.bagService,
////            favoriteService: container.favoriteService
////        )
////        return BagViewModel(useCase: useCase)
////    }
//    
//    public func makeBagViewModel() -> BagViewModelProtocol {
//        let useCase = BagUseCaseImpl(
//            bagService: container.bagService,
//            favoriteService: container.favoriteService
//        )
//        return BagViewModel(useCase: useCase)
//    }
//}

