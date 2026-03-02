//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

import AppDomain

public enum HomeSectionPayload {
    case welcome(WelcomeSectionModel)
    case becauseYouLike(BecauseYouLikeModel)
    case promo(PromoSectionModel)
    case newFromNike(NewFromNikeSectionModel)
    case storiesForYou(StoriesForYouModel)
    case thankYou(ThankYouSectionModel)
}
