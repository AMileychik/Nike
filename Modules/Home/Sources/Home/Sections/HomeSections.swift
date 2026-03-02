//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit
import AppDomain

public enum HomeSections {
    case welcome(String)
    case becauseYouLike([Product], header: Header)
    case promo([Product])
    case newFromNike([NewFromNikeModel], header: Header)
    case storiesForYou([StoriesForYou])
    case thankYou([Product])
}
