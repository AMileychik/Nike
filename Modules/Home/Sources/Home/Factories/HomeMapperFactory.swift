//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation

// MARK: - HomeMapperFactory
///
/// Factory responsible for creating all mappers used on the Home screen.
/// Provides a single point to get instances of mappers for different sections,
/// keeping the creation logic centralized and decoupled from the ViewController or ViewModel.

public final class HomeMapperFactory: HomeMapperFactoryProtocol {

    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}

    // MARK: - Public Factory Methods
    
    /// Mapper for "Because You Like" products section.
    /// Transforms domain models into view data for UI presentation.
    public func makeBecauseYouLikeMapper() -> ProductToBecauseYouLikeMapperProtocol {
        ProductToBecauseYouLikeMapper()
    }

    /// Mapper for promo products section.
    /// Converts promo product domain models into PromoPageViewData for the carousel.
    public func makePromoMapper() -> ProductToPromoPageMapperProtocol {
        ProductToPromoPageMapper()
    }
    
    /// Mapper for the welcome section.
    public func makeWelcomeMapper() -> WelcomeSectionMapperProtocol {
        WelcomeSectionMapper()
    }
    
    /// Mapper for the "Thank You" section.
    public func makeThankYouMapper() -> ThankYouSectionMapperProtocol {
        ThankYouSectionMapper()
    }
    
    /// Another mapper for "Because You Like" products (optional alias for clarity).
    public func makeProductToBecauseYouLikeMapper() -> ProductToBecauseYouLikeMapperProtocol {
        ProductToBecauseYouLikeMapper()
    }
    
    /// Mapper for the "Stories For You" section.
    public func makeStoriesForYouMapper() -> StoriesForYouMapperProtocol {
        StoriesForYouMapper()
    }
    
    /// Mapper for the "New From Nike" section.
    public func makeNewFromNikeMapper() -> NewFromNikeMapperProtocol {
        NewFromNikeMapper()
    }
}

