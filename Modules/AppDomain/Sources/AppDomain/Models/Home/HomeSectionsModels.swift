//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/16/25.
//

import Foundation

public struct WelcomeSectionModel {
    public let isPersonalized: Bool?
    public let title: String
    
    public init(isPersonalized: Bool? = nil, title: String) {
        self.isPersonalized = isPersonalized
        self.title = title
    }
}

public struct PromoSectionModel {
    public let products: [Product]
    
    public init(products: [Product]) {
        self.products = products
    }
}

public struct ThankYouSectionModel: Codable {
    public let image: String
}

public struct BecauseYouLikeModel {
    public let header: Header
    public let products: [Product]
    
    public init(header: Header, products: [Product]) {
        self.header = header
        self.products = products
    }
}

public struct StoriesForYouModel {
    public let header: Header
    public let products: [StoriesForYou]
    
    public init(header: Header, products: [StoriesForYou]) {
        self.header = header
        self.products = products
    }
}
