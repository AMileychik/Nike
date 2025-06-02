//
//  HomeViewModelEvents.swift
//  Nike
//
//  Created by Александр Милейчик on 5/30/25.
//

import UIKit

enum HomeViewModelEvent {
    case homeTopPicksDidTap(_ model: TopPickSelection)
    case promoDidTap(_ model: [Product])
    case newFromNikeDidTap(_ model: [NewFromNikeModel])
    case storiesForYouDidTap(_ model: [StoriesForYou])
    case refreshData
    case barButtonDidTap
    case headerButtonDidTap
    case exploreButtonDidTap(_ model: [NewFromNikeModel])
}

enum HomeViewModelState {
    case initial
    case loading
    case loaded(HomeSectionsResponse)
    case error(String)
}

enum HomeRoute {
    case becauseYouLike(TopPickSelection)
    case promo([Product])
    case stories([StoriesForYou])
    case newFromNike([NewFromNikeModel])
    case explore([NewFromNikeModel])
    case comingSoon(from: UIViewController)
}



