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
    
    public init(container: DependencyContainerProtocol, 
                uiComponentsFactory: BagUIComponentsFactoryProtocol,
                homeUiComponentsFactory: HomeUIComponentsFactoryProtocol,
                detailUiComponentsFactory: DetailUIComponentsFactoryProtocol)
    {
        self.container = container
        self.uiComponentsFactory = uiComponentsFactory
        self.homeUiComponentsFactory = homeUiComponentsFactory
        self.detailUiComponentsFactory = detailUiComponentsFactory
    }
    
    public func makeHomeFeature() -> FeatureModuleProtocol {
        let detailVM = DetailViewModelFactory(container: container)
        let detailScreen = DetailScreenFactory(uiComponentsFactory: detailUiComponentsFactory)
        
        let detailCoordinatorFactory = DetailCoordinatorFactory(
            screenFactory: detailScreen,
            viewModelFactory: detailVM)
        
        let vm = HomeViewModelFactory(container: container)
        let screen = HomeScreenFactory(uiComponentsFactory: homeUiComponentsFactory)
        
        let coordinator = HomeCoordinatorFactory(screenFactory: screen, viewModelFactory: vm, detailCoordinatorFctory: detailCoordinatorFactory)
        
        return FeatureModule(viewModelFactory: vm, screenFactory: screen, makeCoordinator: { nav in
                coordinator.makeHomeCoordinator(navigationController: nav)
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
