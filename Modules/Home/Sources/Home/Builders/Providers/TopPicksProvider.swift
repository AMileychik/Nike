//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation
import AppDomain

public struct TopPicksProvider: HomeSectionProviderProtocol {
    public let priority = HomeSectionPriority.becauseYouLike
    
    public init() {}

    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        guard !response.topPicks.isEmpty else { return nil }
        
        let model = BecauseYouLikeModel(
            header: response.topPicksHeader,
            products: response.topPicks
        )
        return HomeSectionModel(
            type: .becauseYouLike,
            data: .becauseYouLike(model)
        )
    }
}
