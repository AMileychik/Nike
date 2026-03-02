//
//  DetailViewModel.swift
//  Nike
//
//  Created by Александр Милейчик on 6/1/25.
//

//import UIKit
//import AppCore
//import AppDomain
//import AppInterface
//
//public final class DetailViewModel: DetailViewModelProtocol {
//        
//    public var detailSections: [DetailSection] = []
//    public let useCase: DetailUseCaseProtocol
//    public var selectedSubCategory: SubCategoryModel?
//    
//    public var stateChanged: ((DetailViewModelState) -> Void)?
//    public var effectHandler: ((DetailEffect) -> Void)?
//    
//    public init(useCase: DetailUseCaseProtocol) {
//        self.useCase = useCase
//    }
//}


import Combine
import UIKit
import AppDomain
import AppInterface

// MARK: - DetailViewModel
public final class DetailViewModel: DetailViewModelProtocol {
    
    // MARK: Output closures (UIKit)
    public var stateChanged: ((DetailViewModelState) -> Void)?
    public var effectHandler: ((DetailEffect) -> Void)?
    
    // MARK: - Combine
        
    @Published private(set) var state: DetailViewModelState = .initial
    @Published private(set) var effect: DetailEffect?
    
    public var statePublisher: AnyPublisher<DetailViewModelState, Never> {
        $state.eraseToAnyPublisher()
    }
    
    public var effectPublisher: AnyPublisher<DetailEffect, Never> {
        $effect.compactMap { $0 }.eraseToAnyPublisher()
    }
    
    // MARK: - Data
    public var detailSections: [DetailSection] = []
    public let useCase: DetailUseCaseProtocol
    public var selectedSubCategory: SubCategoryModel?
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Init
    public init(useCase: DetailUseCaseProtocol) {
        self.useCase = useCase
        
        // UIKit binding
        $state
            .sink { [weak self] state in
                self?.stateChanged?(state)
            }
            .store(in: &cancellables)
        
        $effect
            .compactMap { $0 }
            .sink { [weak self] effect in
                self?.effectHandler?(effect)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
extension DetailViewModel {
    
    public func loadData(_ data: DetailData) {
        state = .loading
        let uiModel = DetailMapper.map(data)
        state = .loaded(uiModel)
    }
    
    public func sendEvent(_ action: DetailViewModelEvent) {
        switch action {
        case .completeTheLookDidTap:
            effect = .comingSoon
        }
    }
    
    public func addToBag(_ categories: [SubCategoryModel]) {
        if let selected = selectedSubCategory {
            useCase.saveAndAddToBag([selected])
        } else if let first = categories.first {
            selectedSubCategory = first
            useCase.saveAndAddToBag([first])
        }
    }
    
    public func addToFavorites(_ categories: [SubCategoryModel]) {
        if let selected = selectedSubCategory {
            useCase.saveAndAddToFavorite([selected])
        } else if let first = categories.first {
            selectedSubCategory = first
            useCase.saveAndAddToFavorite([first])
        }
    }
    
    public func updateSelectedSubCategory(_ model: SubCategoryModel) {
        selectedSubCategory = model
    }
    
    public func didRequestAddToBag(with categories: [SubCategoryModel]) {
        addToBag(categories)
    }
    
    public func didRequestAddToFavorites(with categories: [SubCategoryModel]) {
        addToFavorites(categories)
    }
}

// MARK: - Sections helpers
extension DetailViewModel {
    public func numberOfSections() -> Int { detailSections.count }
    public func section(at index: Int) -> DetailSection? {
        guard index >= 0 && index < detailSections.count else { return nil }
        return detailSections[index]
    }
}
