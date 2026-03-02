//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ShopVCMenModels: Codable {
    public let newThisWeekSection: [Product]
    public let shopListSection: [Product]
    public let titleHeaderModel: Header
    public let recentlyViewedSection: [Product]?
    public let classicsSpotlight: [Product]?
    public let shoesSectionHeader: Header
    public let shoesSection: [Product]
    public let nikeZoomFly6Header: Header
    public let nikeZoomFly6: [Product]
    public let rafaelNadalHeader: Header
    public let rafaelNadal: [Product]
    public let clothingHeader: Header
    public let clothing: [Product]
    public let nearbyStoresHeader: Header
    public let nearbyStores: [Product]
    public let jacketsHeader: Header
    public let jackets: [Product]
    
    public init(
        newThisWeekSection: [Product],
        shopListSection: [Product],
        titleHeaderModel: Header,
        recentlyViewedSection: [Product]?,
        classicsSpotlight: [Product]?,
        shoesSectionHeader: Header,
        shoesSection: [Product],
        nikeZoomFly6Header: Header,
        nikeZoomFly6: [Product],
        rafaelNadalHeader: Header,
        rafaelNadal: [Product],
        clothingHeader: Header,
        clothing: [Product],
        nearbyStoresHeader: Header,
        nearbyStores: [Product],
        jacketsHeader: Header,
        jackets: [Product]
    ) {
        self.newThisWeekSection = newThisWeekSection
        self.shopListSection = shopListSection
        self.titleHeaderModel = titleHeaderModel
        self.recentlyViewedSection = recentlyViewedSection
        self.classicsSpotlight = classicsSpotlight
        self.shoesSectionHeader = shoesSectionHeader
        self.shoesSection = shoesSection
        self.nikeZoomFly6Header = nikeZoomFly6Header
        self.nikeZoomFly6 = nikeZoomFly6
        self.rafaelNadalHeader = rafaelNadalHeader
        self.rafaelNadal = rafaelNadal
        self.clothingHeader = clothingHeader
        self.clothing = clothing
        self.nearbyStoresHeader = nearbyStoresHeader
        self.nearbyStores = nearbyStores
        self.jacketsHeader = jacketsHeader
        self.jackets = jackets
    }
}
