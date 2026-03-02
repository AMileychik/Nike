//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppDomain

public enum HomeViewModelEvent {
    case homeTopPicksDidTap(_ model: TopPickSelection)
    case promoDidTap(_ model: [Product])
    case newFromNikeDidTap(_ model: [NewFromNikeModel])
    case storiesForYouDidTap(_ model: [StoriesForYou])
    case refreshData
    case barButtonDidTap
    case headerButtonDidTap
    case exploreButtonDidTap(_ model: [NewFromNikeModel])
}
