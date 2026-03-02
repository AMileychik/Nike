//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

public final class HomeBinder: HomeBinderProtocol {

    public let viewBinder: ViewBinderProtocol
    public let stateHandler: StateHandlerProtocol
    public let effectHandler: EffectHandlerProtocol
    
    public init(
        viewBinder: ViewBinderProtocol,
                stateHandler: StateHandlerProtocol,
                effectHandler: EffectHandlerProtocol)
    {
        self.viewBinder = viewBinder
        self.stateHandler = stateHandler
        self.effectHandler = effectHandler
    }
    
    public func bind() {
        viewBinder.bind()
        stateHandler.bind()
        effectHandler.bind()
    }
}

