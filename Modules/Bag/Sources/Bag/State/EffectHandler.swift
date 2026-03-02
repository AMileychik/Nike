//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

public final class EffectHandler: EffectHandlerProtocol {
    
    private let output: BagViewModelOutput
    public let router: BagCoordinatorProtocol
    
    public init(output: BagViewModelOutput, router: BagCoordinatorProtocol) {
        self.output = output
        self.router = router
    }
    
    public func bind() {
        output.effectHandler = { [weak self] effect in
            self?.handleEffect(effect)
        }
    }
    
    private func handleEffect(_ effect: BagEffect) {
        switch effect {
            
        case .presentComingSoon:
            router.presentComingSoonVC()
            
        case .showQuantityPicker(let model):
            router.showQuantityPicker(for: model)
        }
    }
}

