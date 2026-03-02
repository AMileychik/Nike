//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct HomeSectionsResponse: Codable {
    public let topPicksHeader: Header
    public let topPicks: [Product]
    public let promo: [Product]
    public let newFromNikeHeader: Header
    public let newFromNike: [NewFromNikeModel]
    public let nikeTrainingHeader: Header
    public let nikeTraining: [Product]
    public let storiesForYou: [StoriesForYou]
    public let nikeSwiftAndStrideHeader: Header
    public let nikeSwiftAndStride: [Product]
    public let thankYou: [Product]
    
    public init(
        topPicksHeader: Header,
        topPicks: [Product],
        promo: [Product],
        newFromNikeHeader: Header,
        newFromNike: [NewFromNikeModel],
        nikeTrainingHeader: Header,
        nikeTraining: [Product],
        storiesForYou: [StoriesForYou],
        nikeSwiftAndStrideHeader: Header,
        nikeSwiftAndStride: [Product],
        thankYou: [Product]
    ) {
        self.topPicksHeader = topPicksHeader
        self.topPicks = topPicks
        self.promo = promo
        self.newFromNikeHeader = newFromNikeHeader
        self.newFromNike = newFromNike
        self.nikeTrainingHeader = nikeTrainingHeader
        self.nikeTraining = nikeTraining
        self.storiesForYou = storiesForYou
        self.nikeSwiftAndStrideHeader = nikeSwiftAndStrideHeader
        self.nikeSwiftAndStride = nikeSwiftAndStride
        self.thankYou = thankYou
    }
}
