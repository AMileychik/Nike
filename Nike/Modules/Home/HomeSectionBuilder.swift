//
//  HomeSectionBuilder.swift
//  Nike
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

enum HomeSection {
    case welcome(String)
    case becauseYouLike([Product], header: Header)
    case promo([Product])
    case newFromNike([NewFromNikeModel], header: Header)
    case storiesForYou([StoriesForYou])
    case thankYou([Product])
}

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
