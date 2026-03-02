//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation

import Detail

// MARK: - HomeCoordinatorDependencies

/// Encapsulates all external dependencies required by `HomeCoordinator`.
public struct HomeCoordinatorDependencies {
    
    // MARK: - Factories
    
    public let viewModelFactory: HomeViewModelFactoryProtocol
    public let screenFactory: HomeScreenFactoryProtocol
    public let binderFactory: HomeBinderFactoryProtocol
    public let errorMapperFactory: HomeErrorMappingFactoryProtocol
    public let detailCoordinatorFactory: DetailCoordinatorFactoryProtocol
    
    // MARK: - Builders
    
    public let sectionBuilder: HomeSectionBuildingProtocol
    
    // MARK: - Navigation
    
    public let navigationConfigurator: HomeNavigationConfiguratorProtocol
    
    // MARK: - Initialization
    
    public init(
        viewModelFactory: HomeViewModelFactoryProtocol,
        screenFactory: HomeScreenFactoryProtocol,
        binderFactory: HomeBinderFactoryProtocol,
        errorMapperFactory: HomeErrorMappingFactoryProtocol,
        detailCoordinatorFactory: DetailCoordinatorFactoryProtocol,
        sectionBuilder: HomeSectionBuildingProtocol,
        navigationConfigurator: HomeNavigationConfiguratorProtocol
    ) {
        self.viewModelFactory = viewModelFactory
        self.screenFactory = screenFactory
        self.binderFactory = binderFactory
        self.errorMapperFactory = errorMapperFactory
        self.detailCoordinatorFactory = detailCoordinatorFactory
        self.sectionBuilder = sectionBuilder
        self.navigationConfigurator = navigationConfigurator
    }
}
