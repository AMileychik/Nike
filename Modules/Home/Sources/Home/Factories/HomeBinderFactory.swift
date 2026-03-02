//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation

public final class HomeBinderFactory: HomeBinderFactoryProtocol {
    
    // MARK: - Init
    
    public init() {}
    
    /// Factory for creating `HomeBinder` instances.
    /// Handles creation of all necessary components: `ViewBinder`, `StateHandler`, `EffectHandler`.
    public func makeBinder(
        viewModel: HomeViewModelProtocol,
        viewController: HomeViewDisplayingProtocol,
        router: HomeCoordinatorProtocol
    ) -> HomeBinderProtocol {
        
        // MARK: - Create components
        let viewBinder = ViewBinder(input: viewModel, viewController: viewController)
        let stateHandler = StateHandler(output: viewModel, homeScreen: viewController)
        let effectHandler = EffectHandler(output: viewModel, router: router)
        
        // MARK: - Compose binder
        return HomeBinder(
            viewBinder: viewBinder,
            stateHandler: stateHandler,
            effectHandler: effectHandler
        )
    }
}
