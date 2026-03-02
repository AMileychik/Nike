//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation

// MARK: - HomeBinderFactory

/// Factory responsible for creating `HomeBinder` instances for the Home feature.
///
/// Responsibilities:
/// - Encapsulates the creation of all components needed to bind the ViewModel, ViewController, and Coordinator.
/// - Ensures that state, effects, and UI bindings are correctly composed.
public final class HomeBinderFactory: HomeBinderFactoryProtocol {
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - Public Factory Method
    
    /// Creates a `HomeBinder` instance.

    public func makeBinder(
        viewModel: HomeViewModelProtocol,
        viewController: HomeViewDisplayingProtocol,
        router: HomeCoordinatorProtocol
    ) -> HomeBinderProtocol {
        
        // MARK: - Create components
        
        /// Binds ViewModel input to ViewController UI updates.
        let viewBinder = ViewBinder(input: viewModel, viewController: viewController)
        
        /// Observes ViewModel output and updates the Home screen state.
        let stateHandler = StateHandler(output: viewModel, homeScreen: viewController)
        
        /// Observes ViewModel effects and triggers navigation via the router.
        let effectHandler = EffectHandler(output: viewModel, router: router)
        
        // MARK: - Compose binder
        
        return HomeBinder(
            viewBinder: viewBinder,
            stateHandler: stateHandler,
            effectHandler: effectHandler
        )
    }
}

