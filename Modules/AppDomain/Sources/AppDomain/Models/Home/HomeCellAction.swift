//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

import Foundation

public protocol AnyItemProtocol {
    var product: Product { get }
    var title: String { get }
    var subtitle: String? { get }
    var imageURL: String? { get }
    var priceLabel: Int? { get }
}


public enum HomeCellAction {
    case becauseYouLikeItemSelected(AnyItemProtocol)
    case becauseYouLikeHeader(BecauseYouLikeAction<AnyItemProtocol>)
    
    case storiesForYou(StoriesForYouAction<StoriesForYouProps>)
    case promo(PromoActions)
    case newFromNike(NewFromNikeAction)
}

public enum PromoActions {
    case didTap(page: PromoPageViewData)
}

public struct PromoPageViewData {
    public let image: String?
    public let title: String?
    public let subtitle: String?
    public let fullDescription: String?
    public let type: String?
    public let description: String?
    
    public init(
        image: String?,
        title: String?,
        subtitle: String?,
        fullDescription: String?,
        type: String?,
        description: String?
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.fullDescription = fullDescription
        self.type = type
        self.description = description
    }
}

public enum NewFromNikeAction {
    case headerButton
    case videoBottomButton
    case productSelected(NewFromNikeRowProps)
}

public enum BecauseYouLikeAction<Item> {
    case itemSelected(TopPickSelection)
    case headerButtonTapped
}

public enum StoriesForYouAction<Item> {
    case headerButton
    case bottomButton
    case storySelected([StoriesForYou])
}

public enum PromoAction {
    case didTap(model: Product)
}


public struct NewFromNikeSectionViewData {
    
    public let header: Header
    public let rows: [NewFromNikeRowProps]
    
    public init(header: Header, rows: [NewFromNikeRowProps]) {
        self.header = header
        self.rows = rows
    }
}

public struct NewFromNikeRowProps {
    
    public init(content: Content, height: CGFloat, addGradient: Bool) {
        self.content = content
        self.height = height
        self.addGradient = addGradient
    }
    
    
    public struct VideoProps {
        public let videoURL: String
        public let description: String?
        public let image: String?
        
        public init(
            videoURL: String,
            description: String?,
            image: String?
        ) {
            self.videoURL = videoURL
            self.description = description
            self.image = image
        }
    }
    
    public enum Content {
        case video(VideoProps)
        case product(ProductProps)
    }
    
    public let content: Content
    public let height: CGFloat
    public let addGradient: Bool
}

public struct ProductProps {
    
    public let image: String
    public let logoTitle: String
    public let description: String
    
    public let productData: [Product]
    public let completeTheLookHeader: CompleteTheLookHeader
    public let completeTheLookModel: [CompleteTheLookModel]
    
    public init(image: String, logoTitle: String, description: String, productData: [Product], completeTheLookHeader: CompleteTheLookHeader, completeTheLookModel: [CompleteTheLookModel]) {
        self.image = image
        self.logoTitle = logoTitle
        self.description = description
        self.productData = productData
        self.completeTheLookHeader = completeTheLookHeader
        self.completeTheLookModel = completeTheLookModel
    }
}

public extension NewFromNikeRowProps {
    public func toModel() -> NewFromNikeModel {
        switch content {
        case .video(let props):
            return NewFromNikeModel(
                videoURL: nil,
                image: props.image,
                logoTitle: nil,
                detailImage: nil,
                title: nil,
                description: props.description,
                productData: nil,
                completeTheLookHeader: nil,
                completeTheLookModel: nil
            )
        case .product(let props):
            return NewFromNikeModel(
                videoURL: nil,
                image: props.image,
                logoTitle: props.logoTitle,
                detailImage: nil,
                title: nil,
                description: props.description,
                productData: props.productData,
                completeTheLookHeader: props.completeTheLookHeader,
                completeTheLookModel: props.completeTheLookModel
            )
        }
    }
}

public protocol StoriesForYouPropsProtocol {
    var product: StoriesForYou { get }
    
    var title: String { get }
    var rightButtonTitle: String { get }
    var large: String { get }
    var largeImageLabel1: String { get }
    var small1: String { get }
    var small2: String { get }
    var bottomButtonTitle: String { get }
}

public struct StoriesForYouProps: StoriesForYouPropsProtocol {
    
    public let product: StoriesForYou
    
    public let title: String
    public let rightButtonTitle: String
    public let large: String
    public let largeImageLabel1: String
    public let small1: String
    public let small2: String
    public let bottomButtonTitle: String
    
    public init(product: StoriesForYou, title: String, rightButtonTitle: String, large: String, largeImageLabel1: String, small1: String, small2: String, bottomButtonTitle: String) {
        
        self.product = product
        self.title = title
        self.rightButtonTitle = rightButtonTitle
        self.large = large
        self.largeImageLabel1 = largeImageLabel1
        self.small1 = small1
        self.small2 = small2
        self.bottomButtonTitle = bottomButtonTitle
    }
}


public struct PromoCarouselViewData {
    public let pages: [PromoPageViewData]
    
    public init(pages: [PromoPageViewData]) {
        self.pages = pages
    }
}

public extension PromoPageViewData {
    public func toProduct() -> Product {
        Product(
            id: nil,
            count: nil,
            image: image,
            image2: nil,
            specialImage: nil,
            logoImage: nil,
            description: description,
            fullDescription: fullDescription,
            type: type,
            storeHours: nil,
            price: nil,
            categories: nil,
            categoryName: nil,
            detailButtonsName: nil,
            promo: nil,
            header: nil,
            productSizeHeader: nil,
            productSize: nil,
            newArrivalsHeader: nil,
            newArrivals: nil,
            productDescription: nil,
            completeTheLookHeader: nil,
            completeTheLook: nil,
            youMightAlsoLike: nil,
            youMightAlsoLikeHeader: nil,
            verticalProductModel: nil,
            productInfo: nil,
            descriptionModel: nil
        )
    }
}
