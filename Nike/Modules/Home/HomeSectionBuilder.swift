//
//  HomeSectionBuilder.swift
//  LagomStore
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

final class HomeSectionBuilder {
    
    static func createHomeSections(from response: HomeSectionsResponse) -> [HomeSection] {
        return [
            .welcome(Date().welcomeText),
            .becauseYouLike(response.topPicks, header: response.topPicksHeader),
            .promo(response.promo),
            .newFromNike(response.newFromNike, header: response.newFromNikeHeader),
            .becauseYouLike(response.nikeTraining, header: response.nikeTrainingHeader),
            .storiesForYou(response.storiesForYou),
            .becauseYouLike(response.nikeSwiftAndStride, header: response.nikeSwiftAndStrideHeader),
            .thankYou(response.thankYou)
        ]
    }
}
