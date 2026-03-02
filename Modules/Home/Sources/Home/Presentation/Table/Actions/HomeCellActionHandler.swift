//
//  File.swift
//
//
//  Created by Александр Милейчик on 11/16/25.
//

import Foundation

import AppDomain
import DesignSystem

// MARK: - HomeCellActionHandler

/// Handles user interactions from Home feature cells and forwards
/// them as events to the `HomeViewModelProtocol`.
public class HomeCellActionHandler: HomeCellActionHandlerProtocol {
    
    // MARK: - Dependencies
    
    private let viewModel: HomeViewModelProtocol
    private let mapper: ProductToBecauseYouLikeMapperProtocol
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - viewModel: Receives events triggered by cell actions.
    ///   - mapper: Converts UI models to domain models for "Because You Like" section.
    init(
        viewModel: HomeViewModelProtocol,
        mapper: ProductToBecauseYouLikeMapperProtocol
    ) {
        self.viewModel = viewModel
        self.mapper = mapper
    }
    
    // MARK: - Public API

    public func handle(_ action: HomeCellAction, at indexPath: IndexPath) {
        switch action {
        case .becauseYouLikeHeader:
            viewModel.sendEvent(.headerButtonDidTap)
            
        case .becauseYouLikeItemSelected(let item):
            let selection = mapper.mapToDomain(item)
            viewModel.sendEvent(.homeTopPicksDidTap(selection))
            
        case .storiesForYou(let action):
            handleStoriesForYou(action)
            
        case .promo(let action):
            handlePromo(action)
            
        case .newFromNike(let action):
            handleNewFromNike(action)
        }
    }
}

// MARK: - Private Handlers

private extension HomeCellActionHandler {
    
    /// Handles actions from the "New From Nike" section.
    func handleNewFromNike(_ action: NewFromNikeAction) {
        switch action {
        case .headerButton:
            viewModel.sendEvent(.headerButtonDidTap)
        case .videoBottomButton:
            viewModel.sendEvent(.barButtonDidTap)
        case .productSelected(let row):
            let model = row.toModel()
            viewModel.sendEvent(.newFromNikeDidTap([model]))
        }
    }
    
    /// Handles actions from the "Because You Like" section.
    func handleBecauseYouLike(_ action: BecauseYouLikeAction<Product>) {
        switch action {
        case .itemSelected(let item):
            viewModel.sendEvent(.homeTopPicksDidTap(item))
        case .headerButtonTapped:
            viewModel.sendEvent(.headerButtonDidTap)
        }
    }
    
    /// Handles actions from the Promo section.
    func handlePromo(_ action: PromoActions) {
        switch action {
        case .didTap(page: let page):
            let product = page.toProduct()
            viewModel.sendEvent(.promoDidTap([product]))
        }
    }
    
    /// Handles actions from the Stories For You section.
    func handleStoriesForYou(_ action: StoriesForYouAction<StoriesForYouProps>) {
        switch action {
        case .headerButton:
            viewModel.sendEvent(.headerButtonDidTap)
        case .bottomButton:
            viewModel.sendEvent(.barButtonDidTap)
        case .storySelected(let models):
            viewModel.sendEvent(.storiesForYouDidTap(models))
        }
    }
}
