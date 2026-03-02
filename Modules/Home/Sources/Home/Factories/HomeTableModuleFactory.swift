//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation
import AppDomain
import AppInterface

// Describe the purpose of HomeTableModuleFactory
 
public final class HomeTableModuleFactory: HomeTableModuleFactoryProtocol {
    
    // MARK: - Dependencies
    
    private let uiComponentsFactory: HomeUIComponentsFactoryProtocol
    private let mapperFactory: HomeMapperFactoryProtocol
    private let viewModelFactory: HomeViewModelFactory
    
    // MARK: - Init
    
    public init(
        uiComponentsFactory: HomeUIComponentsFactoryProtocol,
        mapperFactory: HomeMapperFactoryProtocol,
        viewModelFactory: HomeViewModelFactory
    ) {
        self.uiComponentsFactory = uiComponentsFactory
        self.mapperFactory = mapperFactory
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - Public
    
    /// Creates a HomeTableViewContainer with all necessary controllers and adapters for the Home screen.
    public func makeTableContainer(for viewModel: HomeViewModelProtocol) -> HomeTableViewContainer {
        let controller = makeController(for: viewModel)
        return uiComponentsFactory.makeTableViewContainer(controller: controller)
    }
    
    // MARK: - Private Helpers
    
    /// Creates the HomeTableController with adapter and manager
    private func makeController(for viewModel: HomeViewModelProtocol) -> HomeTableController {
        let adapter = makeAdapter(for: viewModel)
        let manager = HomeTableViewManager()
        return HomeTableController(adapter: adapter, manager: manager)
    }
   
    /// Creates the adapter for HomeTableView with action handler and cell factory
    private func makeAdapter(for viewModel: HomeViewModelProtocol) -> HomeTableViewAdapter {
       
        // Create action handler for cell user interactions
        let actionHandler = HomeCellActionHandler(viewModel: viewModel, mapper: mapperFactory.makeProductToBecauseYouLikeMapper())
        
        // Create cell factory with all registered builders
        let cellFactory = HomeCellFactory(
            registry: makeCellBuilderRegistry(),
            featureSectionBuilder: makeFeatureSectionBuilder())
        
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
    
    private func makeFeatureSectionBuilder() -> HomeFeatureSectionBuildingProtocol {
        HomeFeatureSectionBuilder(
            homeMapperFactoryProtocol: mapperFactory,
            viewModelFactory: viewModelFactory
        )
    }
}
