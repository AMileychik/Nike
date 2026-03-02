//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ShopVCWomenModels: Codable {
    public let newThisWeekHeader: Header
    public let newThisWeekSection: [Product]
    public let shopListSection: [Product]
    public let facesOfInspirationHeader: Header
    public let facesOfInspiration: [Product]
    public let recentlyViewedSection: [Product]
    public let recentlyViewedHeader: Header
    public let classicsSpotlightHeader: Header
    public let classicsSpotlight: [Product]
    public let jordanSneakersHeader: Header
    public let jordanSneakersSection: [Product]
    public let nearbyStoresHeader: Header
    public let nearbyStores: [Product]
    
    public init(
        newThisWeekHeader: Header,
        newThisWeekSection: [Product],
        shopListSection: [Product],
        facesOfInspirationHeader: Header,
        facesOfInspiration: [Product],
        recentlyViewedSection: [Product],
        recentlyViewedHeader: Header,
        classicsSpotlightHeader: Header,
        classicsSpotlight: [Product],
        jordanSneakersHeader: Header,
        jordanSneakersSection: [Product],
        nearbyStoresHeader: Header,
        nearbyStores: [Product]
    ) {
        self.newThisWeekHeader = newThisWeekHeader
        self.newThisWeekSection = newThisWeekSection
        self.shopListSection = shopListSection
        self.facesOfInspirationHeader = facesOfInspirationHeader
        self.facesOfInspiration = facesOfInspiration
        self.recentlyViewedSection = recentlyViewedSection
        self.recentlyViewedHeader = recentlyViewedHeader
        self.classicsSpotlightHeader = classicsSpotlightHeader
        self.classicsSpotlight = classicsSpotlight
        self.jordanSneakersHeader = jordanSneakersHeader
        self.jordanSneakersSection = jordanSneakersSection
        self.nearbyStoresHeader = nearbyStoresHeader
        self.nearbyStores = nearbyStores
    }
}
