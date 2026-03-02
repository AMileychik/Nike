//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

import DesignSystem
import AppDomain

public protocol HomeFeatureSectionBuildingProtocol {
    func build(from domain: HomeSectionModel) -> HomeFeatureSection
}

final class HomeFeatureSectionBuilder: HomeFeatureSectionBuildingProtocol {
    
    private let mapperFactory: HomeMapperFactoryProtocol
    private let viewModelFactory: HomeViewModelFactoryProtocol
    
    init(
        homeMapperFactoryProtocol: HomeMapperFactoryProtocol,
        viewModelFactory: HomeViewModelFactoryProtocol
    ) {
        self.mapperFactory = homeMapperFactoryProtocol
        self.viewModelFactory = viewModelFactory
    }
    
    func build(from domain: HomeSectionModel) -> HomeFeatureSection {
        switch domain.data {
        case .welcome(let model):
            return buildWelcomeSection(model)
        case .becauseYouLike(let model):
            return buildBecauseYouLikeSection(model)
        case .promo(let model):
            return buildPromoSection(model)
        case .newFromNike(let model):
            return buildNewFromNikeSection(model)
        case .storiesForYou(let stories):
            return buildStoriesForYouSection(stories)
        case .thankYou(let products):
            return buildThankYouSection(products)
        }
    }
    
    // MARK: - Private Builders
    
    private func buildWelcomeSection(_ model: WelcomeSectionModel) -> HomeFeatureSection {
        let viewData = mapperFactory
            .makeWelcomeMapper()
            .map(model)
        
        return .welcome(viewData)
    }
    
    private func buildBecauseYouLikeSection(_ model: BecauseYouLikeModel) -> HomeFeatureSection {
        let items = model.products.map(mapperFactory
            .makeBecauseYouLikeMapper()
            .map
        )
        
        let viewData = BecauseYouLikeSectionViewData(
            header: model.header,
            items: items
        )
        
        return .becauseYouLike(viewData)
    }
    
    private func buildPromoSection(_ model: PromoSectionModel) -> HomeFeatureSection {
        let pages = model.products.map(mapperFactory
            .makePromoMapper()
            .map)
        
        let viewModel = viewModelFactory.makePromoCarouselViewModel(for: pages)
        
        return .promo(PromoSectionViewData(
            viewData: PromoCarouselViewData(pages: pages),
            viewModel: viewModel))
    }
    
    private func buildNewFromNikeSection(_ model: NewFromNikeSectionModel) -> HomeFeatureSection {
        
        let viewData = mapperFactory
            .makeNewFromNikeMapper()
            .map(model)
        
        return .newFromNike(viewData)
    }
    
    private func buildStoriesForYouSection(_ model: StoriesForYouModel) -> HomeFeatureSection {
        
        let items = model.products.map(
            mapperFactory
                .makeStoriesForYouMapper()
                .map
        )
        
        let viewData = StoriesForYouSectionViewData(
            header: model.header,
            items: items
        )
        
        return .storiesForYou(viewData)
    }
    
    private func buildThankYouSection(_ model: ThankYouSectionModel) -> HomeFeatureSection {
        let viewData = mapperFactory
            .makeThankYouMapper()
            .map(model)
        
        return .thankYou(viewData)
    }
}
