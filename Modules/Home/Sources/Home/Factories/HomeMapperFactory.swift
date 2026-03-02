//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/23/25.
//

import Foundation

/// Factory for creating mappers used on the Home screen.
public final class HomeMapperFactory: HomeMapperFactoryProtocol {

    // MARK: - Init
    
    /// Default initializer.
    public init() {}

    // MARK: - HomeMapperFactoryProtocol
    
    /// Creates a mapper for "Because You Like" products.
    /// - Returns: An instance conforming to `ProductToBecauseYouLikeMapperProtocol`.
    public func makeBecauseYouLikeMapper() -> ProductToBecauseYouLikeMapperProtocol {
        ProductToBecauseYouLikeMapper()
    }

    /// Creates a mapper for promo products.
    /// - Returns: An instance conforming to `ProductToPromoPageMapperProtocol`.
    public func makePromoMapper() -> ProductToPromoPageMapperProtocol {
        ProductToPromoPageMapper()
    }
    
    public func makeWelcomeMapper() -> WelcomeSectionMapperProtocol {
        WelcomeSectionMapper()
    }
    
    public func makeThankYouMapper() -> ThankYouSectionMapperProtocol {
        ThankYouSectionMapper()
    }
    
    public func makeProductToBecauseYouLikeMapper() -> ProductToBecauseYouLikeMapperProtocol {
        ProductToBecauseYouLikeMapper()
    }
    
    public func makeStoriesForYouMapper() -> StoriesForYouMapperProtocol {
        StoriesForYouMapper()
    }
    
    public func makeNewFromNikeMapper() -> NewFromNikeMapperProtocol {
        NewFromNikeMapper()
    }
}

/*
 
 !!! В некоторых местах комментарии слишком очевидные (например, // MARK: - Init). Можно оставить только сложные части.
 
 •   assertionFailure в реальном коде может быть заменена на более безопасный fallback, если приложение в продакшене
 
 •    В HomeMapperFactory есть повторные методы (makeBecauseYouLikeMapper и makeProductToBecauseYouLikeMapper возвращают одно и то же). Можно объединить.
 
 */
