//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import AppComposition
import Bag
import Home
import AppInterface
import UIKit
import Detail

public protocol FeatureAssemblyProtocol: AnyObject {
    func makeHomeFeature() -> FeatureModuleProtocol
    func makeBagFeature() -> FeatureModuleProtocol
}

public final class FeatureAssembly: FeatureAssemblyProtocol {
    
    private let container: DependencyContainerProtocol
    
    private let uiComponentsFactory: BagUIComponentsFactoryProtocol
    private let homeUiComponentsFactory: HomeUIComponentsFactoryProtocol
    private let detailUiComponentsFactory: DetailUIComponentsFactoryProtocol
    private let homeMapperFactory: HomeMapperFactoryProtocol
    private let binderFactory: HomeBinderFactoryProtocol
    
    public init(container: DependencyContainerProtocol, 
                uiComponentsFactory: BagUIComponentsFactoryProtocol,
                homeUiComponentsFactory: HomeUIComponentsFactoryProtocol,
                detailUiComponentsFactory: DetailUIComponentsFactoryProtocol,
                homeMapperFactory: HomeMapperFactoryProtocol,
                binderFactory: HomeBinderFactoryProtocol)
    {
        self.container = container
        self.uiComponentsFactory = uiComponentsFactory
        self.homeUiComponentsFactory = homeUiComponentsFactory
        self.detailUiComponentsFactory = detailUiComponentsFactory
        self.homeMapperFactory = homeMapperFactory
        self.binderFactory = binderFactory
    }
    
    public func makeHomeFeature() -> FeatureModuleProtocol {
        let detailVM = DetailViewModelFactory(container: container)
        let detailScreen = DetailScreenFactory(uiComponentsFactory: detailUiComponentsFactory)
        
        let detailCoordinatorFactory = DetailCoordinatorFactory(
            screenFactory: detailScreen,
            viewModelFactory: detailVM
        )
        
        let binderFactory = HomeBinderFactory()
        let errorMapperFactory = HomeErrorMappingFactory()
        let navigationConfigurator = HomeNavigationConfigurator()
        
        let homeViewModel = HomeViewModelFactory(container: container)
        
        let tableModuleFactory = HomeTableModuleFactory(
            uiComponentsFactory: homeUiComponentsFactory,
            mapperFactory: homeMapperFactory, 
            viewModelFactory: homeViewModel)
        
        let screen = HomeScreenFactory(uiComponentsFactory: homeUiComponentsFactory, tableModuleFactory: tableModuleFactory)
            
        let sectionBuilder = HomeSectionBuilder(providers: [
            WelcomeProvider(),
            TopPicksProvider(),
            PromoProvider(),
            NewFromNikeProvider(),
            NikeTrainingProvider(),
            StoriesProvider(),
            SwiftStrideProvider(),
            ThankYouProvider()
        ])
        
        let homeCoordinatorFactory = HomeCoordinatorFactory(
            screenFactory: screen,
            viewModelFactory: homeViewModel,
            detailCoordinatorFactory: detailCoordinatorFactory,
            binderFactory: binderFactory,
            errorMapperFactory: errorMapperFactory, 
            navigationConfigurator: navigationConfigurator
        )

        let dependencies = HomeCoordinatorDependencies(
            viewModelFactory: homeViewModel,
            screenFactory: screen,
            binderFactory: binderFactory,
            errorMapperFactory: errorMapperFactory,
            detailCoordinatorFactory: detailCoordinatorFactory,
            sectionBuilder: sectionBuilder, 
            navigationConfigurator: navigationConfigurator
        )
        
        return FeatureModule(
            viewModelFactory: homeViewModel,
            screenFactory: screen,
            makeCoordinator: { nav in
                HomeCoordinator(dependencies: dependencies, navigationController: nav)
            }
        )
    }
    
    public func makeBagFeature() -> FeatureModuleProtocol {
        let vm = BagViewModelFactory(container: container)
        let screen = BagScreenFactory(uiComponentsFactory: uiComponentsFactory)
        let coordinator = BagCoordinatorFactory(screenFactory: screen, viewModelFactory: vm, uiComponentsFactory: uiComponentsFactory)
        
        return FeatureModule(viewModelFactory: vm, screenFactory: screen, makeCoordinator: { nav in
                coordinator.makeBagCoordinator(navigationController: nav)
            }
        )
    }
}
