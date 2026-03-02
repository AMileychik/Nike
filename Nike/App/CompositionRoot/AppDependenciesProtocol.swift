//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/30/25.
//

import Bag
import AppInterface
import FeatureAssembly

// MARK: - AppDependenciesProtocol

/// Protocol defining all app-wide dependencies.
///
/// Provides access to:
/// - Global dependency container
/// - Feature modules (Home, Bag)
/// - UI component factories for specific features
public protocol AppDependenciesProtocol: AnyObject {
    
    /// The global dependency container for service registration and resolution.
    var container: DependencyContainerProtocol { get }
    
    /// Home feature module.
    var home: FeatureModuleProtocol { get }
    
    /// Bag feature module.
    var bag: FeatureModuleProtocol { get }
    
    /// Factory for creating UI components for the Bag feature.
    var uiComponentsFactory: BagUIComponentsFactoryProtocol { get }
}
