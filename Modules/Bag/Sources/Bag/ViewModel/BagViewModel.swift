//
//  BagViewModel.swift
//
//
//  Created by Александр Милейчик on 6/19/25.
//

//import Services
//import Bag
//import AppInterface
//
//public final class BagViewModel: BagViewModelProtocol {
//    
//    public var bagSections: [BagSections] = []
//    public let useCase: BagUseCaseProtocol
//    
//    public var stateChanged: ((BagViewModelState) -> Void)?
//    public var effectHandler: ((BagEffect) -> Void)?
//    
//    public init(useCase: BagUseCaseProtocol) {
//        self.useCase = useCase
//    }
//}

import Combine
import Bag
import Services
import AppInterface

public final class BagViewModel: BagViewModelProtocol {

    // MARK: - Output closures (UIKit)
    public var stateChanged: ((BagViewModelState) -> Void)?
    public var effectHandler: ((BagEffect) -> Void)?

    // MARK: - Published
    @Published private(set) var state: BagViewModelState = .initial
    @Published private(set) var bagSections: [BagSections] = []
    @Published private(set) var effect: BagEffect?

    // MARK: - Combine Publishers
    public var statePublisher: AnyPublisher<BagViewModelState, Never> {
        $state.eraseToAnyPublisher()
    }

    public var bagSectionsPublisher: AnyPublisher<[BagSections], Never> {
        $bagSections.eraseToAnyPublisher()
    }

    public var effectPublisher: AnyPublisher<BagEffect, Never> {
        $effect.compactMap { $0 }.eraseToAnyPublisher()
    }

    private let useCase: BagUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    public init(useCase: BagUseCaseProtocol) {
        self.useCase = useCase

        // UIKit state callback
        $state
            .sink { [weak self] in self?.stateChanged?($0) }
            .store(in: &cancellables)

        // UIKit effect callback
        $effect
            .compactMap { $0 }
            .sink { [weak self] in self?.effectHandler?($0) }
            .store(in: &cancellables)
    }
}

extension BagViewModel {

    public func updateSections() {
        state = .loading

        let models = useCase.fetchBagItems()
        let ui = models.map { BagMapper.mapToUIModel(from: $0) }
        let total = useCase.calculateTotalPrice()

        bagSections = BagSectionBuilder.createBagSections(from: ui, totalPrice: total)

        state = .loaded
    }

    public func deleteProduct(_ model: BagProductUIModel) {
        let domain = BagMapper.mapToDomainModel(from: model)
        useCase.deleteItem(domain)
        updateSections()
    }

    public func updateQuantity(for model: BagProductUIModel, count: Double) {
        var domain = BagMapper.mapToDomainModel(from: model)
        domain.count = count
        useCase.updateItem(domain)
        updateSections()
    }

    public func saveAndAddProduct(_ model: BagProductUIModel) {
        let domainModel = BagMapper.mapToDomainModel(from: model)
        useCase.saveFavorite(domainModel)
    }

    public func sendEvent(_ action: BagViewModelEvent) {
        switch action {

        case .bagDidTap:
            effect = .presentComingSoon

        case .quantityPickerDidTap(let model):
            effect = .showQuantityPicker(model)
        }
    }
}
