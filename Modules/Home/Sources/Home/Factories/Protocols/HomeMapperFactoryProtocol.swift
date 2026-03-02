//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

public protocol HomeMapperFactoryProtocol: AnyObject {
    func makeBecauseYouLikeMapper() -> ProductToBecauseYouLikeMapperProtocol
    func makePromoMapper() -> ProductToPromoPageMapperProtocol
    func makeWelcomeMapper() -> WelcomeSectionMapperProtocol
    func makeThankYouMapper() -> ThankYouSectionMapperProtocol
    func makeProductToBecauseYouLikeMapper() -> ProductToBecauseYouLikeMapperProtocol
    func makeStoriesForYouMapper() -> StoriesForYouMapperProtocol
    func makeNewFromNikeMapper() -> NewFromNikeMapperProtocol 
}
