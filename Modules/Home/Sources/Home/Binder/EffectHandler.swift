//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import Combine

// MARK: - EffectHandler

/// Observes one-off effects from the `HomeViewModelOutput`
/// and triggers navigation or other transient actions via `HomeCoordinatorProtocol`.
///
/// Responsibilities:
/// - Subscribes to the view model's effect publisher.
/// - Keeps navigation logic separate from the view controller.
public final class EffectHandler: EffectHandlerProtocol {
    
    // MARK: - Dependencies
    
    private let output: HomeViewModelOutput
    private weak var router: HomeCoordinatorProtocol?
    
    /// Stores Combine subscriptions to manage lifecycle.
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - output: The view model output providing effect updates.
    ///   - router: The coordinator responsible for navigation actions.
    public init(
        output: HomeViewModelOutput,
        router: HomeCoordinatorProtocol
    ) {
        self.output = output
        self.router = router
    }
    
    // MARK: - Public API
    
    /// Starts observing effect updates from the view model.
    public func bind() {
        output.effectPublisher
            .sink { [weak self] effect in
                self?.handleEffect(effect)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private Handlers
    
    /// Maps `HomeEffect` to navigation.
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
