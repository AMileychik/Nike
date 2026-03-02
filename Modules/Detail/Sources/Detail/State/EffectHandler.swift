//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/3/25.
//

//public final class EffectHandler: EffectHandlerProtocol {
//    
//    private let output: DetailViewModelOutput
//    public let router: DetailCoordinatorProtocol
//    
//    public init(output: DetailViewModelOutput, router: DetailCoordinatorProtocol) {
//        self.output = output
//        self.router = router
//    }
//    
//    public func bind() {
//        output.effectHandler = { [weak self] effect in
//            self?.handleEffect(effect)
//        }
//    }
//    
//    private func handleEffect(_ effect: DetailEffect) {
//        switch effect {
//            
//        case .comingSoon:
//            router.navigateToCommingSoonViewController()
//        }
//    }
//}

// MARK: - EffectHandler
import Combine
import UIKit

public final class EffectHandler: EffectHandlerProtocol {
    
    private let output: DetailViewModelProtocol
    public let router: DetailCoordinatorProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    public init(output: DetailViewModelProtocol, router: DetailCoordinatorProtocol) {
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
    
    private func handleEffect(_ effect: DetailEffect) {
        switch effect {
        case .comingSoon:
            router.navigateToCommingSoonViewController()
        }
    }
}
