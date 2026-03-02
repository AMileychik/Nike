//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Bag
import Home
import Detail
import AppComposition
import AppInterface
import FeatureAssembly

// MARK: - AppDependencies

/// Central container for all app-wide dependencies.
///
/// Responsible for creating and providing:
/// - Dependency container (`DependencyContainerProtocol`)
/// - UI component factories for each feature
/// - Mapper and binder factories
/// - Feature modules (Home, Bag, etc.)
///
/// All factories and modules are initialized here and injected wherever needed.
public final class AppDependencies: AppDependenciesProtocol {
    
    // MARK: - Core Dependencies
    
    /// The main feature assembly that constructs feature modules.
    private let assembly: FeatureAssemblyProtocol
    
    /// Global dependency container for service registration and resolution.
    public let container: DependencyContainerProtocol
    
    // MARK: - UI Component Factories
    
    /// UI components for Bag feature.
    public let uiComponentsFactory: BagUIComponentsFactoryProtocol
    
    /// UI components for Home feature.
    public let homeUiComponentsFactory: HomeUIComponentsFactoryProtocol
    
    /// UI components for Detail feature.
    public let detailUiComponentsFactory: DetailUIComponentsFactoryProtocol
    
    // MARK: - Mapper & Binder Factories
    
    /// Mapper factory for Home feature.
    private let homeMapperFactory: HomeMapperFactoryProtocol
    
    /// Binder factory for Home feature.
    private let binderFactory: HomeBinderFactoryProtocol
    
    // MARK: - Feature Modules
    
    /// Home feature module.
    public let home: FeatureModuleProtocol
    
    /// Bag feature module.
    public let bag: FeatureModuleProtocol
    
    // MARK: - Initialization
    
    /// Initializes all dependencies and builds feature modules.
    public init() {
        // Create the dependency container
        container = DependencyContainerFactory.makeDefault()
        
        // Initialize UI component factories
        uiComponentsFactory = BagUIComponentsFactory()
        homeUiComponentsFactory = HomeUIComponentsFactory()
        detailUiComponentsFactory = DetailUIComponentsFactory()
        
        // Initialize mapper and binder factories
        homeMapperFactory = HomeMapperFactory()
        binderFactory = HomeBinderFactory()
        
        // Assemble feature modules
        assembly = FeatureAssembly(
            container: container,
            uiComponentsFactory: uiComponentsFactory,
            homeUiComponentsFactory: homeUiComponentsFactory,
            detailUiComponentsFactory: detailUiComponentsFactory,
            homeMapperFactory: homeMapperFactory,
            binderFactory: binderFactory
        )
        
        // Create Home and Bag features
        home = assembly.makeHomeFeature()
        bag  = assembly.makeBagFeature()
    }
}
