//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

public enum HomeSectionPayload {
    case welcome(WelcomeSectionModel)
    case becauseYouLike(BecauseYouLikeModel)
    case promo(PromoSectionModel)
    case newFromNike(NewFromNikeSectionModel)
    case storiesForYou(StoriesForYouModel)
    case thankYou(ThankYouSectionModel)
}
