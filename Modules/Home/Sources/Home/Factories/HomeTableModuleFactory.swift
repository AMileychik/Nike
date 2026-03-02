//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation

import AppDomain
import AppInterface

// MARK: - HomeTableModuleFactory
///
/// Central factory for building all table-related components in the Home feature.
/// Provides a single point for creating table containers, controllers, adapters, and cell factories.
/// Ensures dependencies are injected consistently and reduces duplication.
///
public final class HomeTableModuleFactory: HomeTableModuleFactoryProtocol {
    
    // MARK: - Dependencies
    
    private let uiComponentsFactory: HomeUIComponentsFactoryProtocol
    private let mapperFactory: HomeMapperFactoryProtocol
    private let viewModelFactory: HomeViewModelFactory
    
    // MARK: - Initialization
    
    public init(
        uiComponentsFactory: HomeUIComponentsFactoryProtocol,
        mapperFactory: HomeMapperFactoryProtocol,
        viewModelFactory: HomeViewModelFactory
    ) {
        self.uiComponentsFactory = uiComponentsFactory
        self.mapperFactory = mapperFactory
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - Public Factory Methods
    
    /// Creates a fully configured HomeTableViewContainer
    /// - Parameter viewModel: HomeViewModel that provides data and handles actions
    /// - Returns: A table container ready to be used in HomeViewController
    public func makeTableContainer(for viewModel: HomeViewModelProtocol) -> HomeTableViewContainer {
        let controller = makeController(for: viewModel)
        return HomeTableViewContainer(controller: controller)
    }
    
    // MARK: - Private Helpers
    
    /// Creates the HomeTableController with adapter and manager
    private func makeController(for viewModel: HomeViewModelProtocol) -> HomeTableController {
        let adapter = makeAdapter(for: viewModel)
        let manager = HomeTableViewManager()
        return HomeTableController(adapter: adapter, manager: manager)
    }
   
    /// Creates the adapter for the HomeTableView
    /// - Sets up cell factories, section builders, and action handlers
    private func makeAdapter(for viewModel: HomeViewModelProtocol) -> HomeTableViewAdapter {
       
        // Handles user interactions in table cells
        let actionHandler = HomeCellActionHandler(
            viewModel: viewModel,
            mapper: mapperFactory.makeProductToBecauseYouLikeMapper()
        )
        
        // Builds cells for each section
        let cellFactory = HomeCellFactory(
            registry: makeCellBuilderRegistry(),
            featureSectionBuilder: makeFeatureSectionBuilder()
        )
        
        return HomeTableViewAdapter(
            viewModel: viewModel,
            cellFactory: cellFactory,
            actionHandler: actionHandler
        )
    }
    
    /// Registers all cell builders for each Home section
    private func makeCellBuilderRegistry() -> HomeCellBuilderRegistry {
        let builders: [HomeSections: HomeCellBuilding] = [
            .welcome: WelcomeCellBuilder(),
            .becauseYouLike: CarouselContainerBuilder(uiFactory: uiComponentsFactory),
            .promo: PromoCellBuilder(),
            .newFromNike: NewFromNikeCellBuilder(),
            .storiesForYou: StoriesForYouCellBuilder(),
            .thankYou: ThankYouCellBuilder()
        ]
        return HomeCellBuilderRegistry(builders: builders)
    }
    
    /// Creates a builder for special feature sections
    private func makeFeatureSectionBuilder() -> HomeFeatureSectionBuildingProtocol {
        HomeFeatureSectionBuilder(
            homeMapperFactoryProtocol: mapperFactory,
            viewModelFactory: viewModelFactory
        )
    }
}
