//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/16/25.
//

import Foundation
//import AppCore

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

//public struct NewFromNikeSectionModel {
//    public let header: Header
//    public let products: [NewFromNikeModel]
//    
//    public init(header: Header, products: [NewFromNikeModel]) {
//        self.header = header
//        self.products = products
//    }
//}

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

//public enum HomeSectionPayload {
//    case welcome(WelcomeSectionModel)
//    case becauseYouLike(BecauseYouLikeModel)
//  //  case promo(PromoSectionModel)
//    case promo(PromoSection)
//    case newFromNike(NewFromNikeSectionModel)
//    case storiesForYou([StoriesForYou])
//    case thankYou([Product])
//}
//
//struct PromoSection {
//    let viewData: PromoCarouselViewData
//    let viewModel: PromoCarouselViewModelProtocol
//}


//public struct HomeSectionModel {
//    public let type: HomeSections
//    public let data: HomeSectionPayload
//
//    public init(type: HomeSections, data: HomeSectionPayload) {
//        self.type = type
//        self.data = data
//    }
//}
//
//extension HomeSectionModel: SectionRepresentable {
//
//    public var numberOfRows: Int {
//        switch data {
//        case .welcome:
//            return 1
//
//        case .becauseYouLike:
//            return 1
//
//        case .promo:
//            return 1
//
//        case .newFromNike:
//            return 1
//
//        case .storiesForYou(let stories):
//            return stories.count
//
//        case .thankYou(let products):
//            return products.count
//        }
//    }
//}
//
//public enum HomeSections {
//    case welcome
//    case becauseYouLike
//    case promo
//    case newFromNike
//    case storiesForYou
//    case thankYou
//}
