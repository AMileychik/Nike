//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

public final class BagBinder: BagBinderProtocol {

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
    
    public func bind() {
        viewBinder.bind()
        stateHandler.bind()
        effectHandler.bind()
    }
}
