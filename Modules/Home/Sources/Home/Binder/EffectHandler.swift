//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import Combine

public final class EffectHandler: EffectHandlerProtocol {
    
    private let output: HomeViewModelOutput
    private weak var router: HomeCoordinatorProtocol?
    private var cancellables: Set<AnyCancellable> = []
    
    public init(output: HomeViewModelOutput, router: HomeCoordinatorProtocol) {
        self.output = output
        self.router = router
    }
    
    public func bind() {
        output.effectPublisher
            .sink { [weak self] effect in
                self?.handleEffect(effect)
            }
            .store(in: &cancellables)
    }
    
    private func handleEffect(_ effect: HomeEffect) {
        switch effect {
            
        case .becauseYouLike(let model):
            router?.showDetail(data: .topPick(model))
            
        case .promo(let model):
            router?.showDetail(data: .promo(model))
            
        case .stories(let model):
            router?.showDetail(data: .stories(model))
            
        case .newFromNike(let model):
            router?.showDetail(data: .newFromNike(model))
            
        case .explore(let model):
            router?.showDetail(data: .verticalNew(model))
            
        case .comingSoon:
            router?.showComingSoon()
        }
    }
}
