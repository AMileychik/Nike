//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

// MARK: - HomeBinder

/// Coordinates all bindings for the Home feature.
///
/// Responsibilities:
/// - Binds user actions to the view model (`ViewBinder`).
/// - Observes state updates and reflects them in the UI (`StateHandler`).
/// - Handles one-off effects such as navigation (`EffectHandler`).
public final class HomeBinder: HomeBinderProtocol {

    // MARK: - Dependencies
    
    public let viewBinder: ViewBinderProtocol
    
    public let stateHandler: StateHandlerProtocol
    
    public let effectHandler: EffectHandlerProtocol
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - viewBinder: Binds user interactions.
    ///   - stateHandler: Observes state changes.
    ///   - effectHandler: Handles effects.
    public init(
        viewBinder: ViewBinderProtocol,
        stateHandler: StateHandlerProtocol,
        effectHandler: EffectHandlerProtocol
    ) {
        self.viewBinder = viewBinder
        self.stateHandler = stateHandler
        self.effectHandler = effectHandler
    }
    
    // MARK: - Public API
    
    /// Activates all bindings for the Home screen.
    public func bind() {
        viewBinder.bind()
        stateHandler.bind()
        effectHandler.bind()
    }
}
