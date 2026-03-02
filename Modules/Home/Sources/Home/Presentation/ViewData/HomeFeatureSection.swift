//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public enum HomeFeatureSection {
    case welcome(WelcomeViewData)
    case becauseYouLike(BecauseYouLikeSectionViewData)
    case promo(PromoSectionViewData)
    case newFromNike(NewFromNikeSectionViewData)
    case storiesForYou(StoriesForYouSectionViewData)
    case thankYou(ThankYouViewData)
}
