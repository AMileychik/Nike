//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit

import AppInterface
import Detail

// MARK: - HomeCoordinatorFactory

/// Factory responsible for creating `HomeCoordinator` instances.
///
/// Encapsulates all dependencies required for constructing the coordinator, including:
/// - ViewModel, ViewController, Binder, Error Mapper, and DetailCoordinator factories.
/// - Navigation configurator for setting up the navigation controller.
public final class HomeCoordinatorFactory: HomeCoordinatorFactoryProtocol, CoordinatorFactoryProtocol {
    
    // MARK: - Dependencies (Factories)
    
    public let screenFactory: HomeScreenFactoryProtocol
    public let viewModelFactory: HomeViewModelFactoryProtocol
    public let detailCoordinatorFactory: DetailCoordinatorFactoryProtocol
    public let binderFactory: HomeBinderFactoryProtocol
    public let errorMapperFactory: HomeErrorMappingFactoryProtocol
    
    // MARK: - Navigation
    
    public let navigationConfigurator: HomeNavigationConfiguratorProtocol
    
    // MARK: - Initialization

    public init(
        screenFactory: HomeScreenFactoryProtocol,
        viewModelFactory: HomeViewModelFactoryProtocol,
        detailCoordinatorFactory: DetailCoordinatorFactoryProtocol,
        binderFactory: HomeBinderFactoryProtocol,
        errorMapperFactory: HomeErrorMappingFactoryProtocol,
        navigationConfigurator: HomeNavigationConfiguratorProtocol
    ) {
        self.screenFactory = screenFactory
        self.viewModelFactory = viewModelFactory
        self.detailCoordinatorFactory = detailCoordinatorFactory
        self.binderFactory = binderFactory
        self.errorMapperFactory = errorMapperFactory
        self.navigationConfigurator = navigationConfigurator
    }
    
    // MARK: - Factory Method
    
    /// Creates a fully configured `HomeCoordinator`.
    public func makeHomeCoordinator(
        navigationController: UINavigationController,
        sectionBuilder: HomeSectionBuildingProtocol
    ) -> HomeCoordinatorProtocol {
        
        let dependencies = HomeCoordinatorDependencies(
            viewModelFactory: viewModelFactory,
            screenFactory: screenFactory,
            binderFactory: binderFactory,
            errorMapperFactory: errorMapperFactory,
            detailCoordinatorFactory: detailCoordinatorFactory,
            sectionBuilder: sectionBuilder,
            navigationConfigurator: navigationConfigurator
        )
        
        return HomeCoordinator(
            dependencies: dependencies,
            navigationController: navigationController
        )
    }
}
