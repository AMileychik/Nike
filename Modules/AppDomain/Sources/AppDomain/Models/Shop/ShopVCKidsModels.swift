//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ShopVCKidsModels: Codable {
    public let newThisWeekSection: [Product]
    public let shopListSection: [Product]
    public let titleHeaderModel: Header
    public let recentlyViewedSection: [Product]?
    public let classicsSpotlight: [Product]?
    public let jordanKidsHeaderModel: Header
    public let jordanKids: [Product]
    public let nikeNewsHeader: Header
    public let nikeNews: [Product]
    public let pinkNikeHeader: Header
    public let pinkNike: [Product]
    
    public init(
        newThisWeekSection: [Product],
        shopListSection: [Product],
        titleHeaderModel: Header,
        recentlyViewedSection: [Product]?,
        classicsSpotlight: [Product]?,
        jordanKidsHeaderModel: Header,
        jordanKids: [Product],
        nikeNewsHeader: Header,
        nikeNews: [Product],
        pinkNikeHeader: Header,
        pinkNike: [Product]
    ) {
        self.newThisWeekSection = newThisWeekSection
        self.shopListSection = shopListSection
        self.titleHeaderModel = titleHeaderModel
        self.recentlyViewedSection = recentlyViewedSection
        self.classicsSpotlight = classicsSpotlight
        self.jordanKidsHeaderModel = jordanKidsHeaderModel
        self.jordanKids = jordanKids
        self.nikeNewsHeader = nikeNewsHeader
        self.nikeNews = nikeNews
        self.pinkNikeHeader = pinkNikeHeader
        self.pinkNike = pinkNike
    }
}
