//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppDomain

public enum HomeEffect {
    case becauseYouLike(TopPickSelection)
    case promo([Product])
    case stories([StoriesForYou])
    case newFromNike([NewFromNikeModel])
    case explore([NewFromNikeModel])
    case comingSoon
}
