//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/3/25.
//

import AppDomain

public final class DetailBinder: DetailBinderProtocol {
    
    public let viewBinder: ViewBinderProtocol
    public let stateHandler: StateHandlerProtocol
    public let effectHandler: EffectHandlerProtocol
    
    public init(viewBinder: ViewBinderProtocol,
                stateHandler: StateHandlerProtocol,
                effectHandler: EffectHandlerProtocol)
    {
        self.viewBinder = viewBinder
        self.stateHandler = stateHandler
        self.effectHandler = effectHandler
    }
    
    public func bind(with data: DetailData) {
        viewBinder.update(with: data)
        stateHandler.bind()
        effectHandler.bind()
    }
}
