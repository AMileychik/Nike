//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

import Foundation

public enum HomeCellAction {
    case becauseYouLike(TopPickSelection)
    case becauseYouLikeHeader(BecauseYouLikeAction<BecauseYouLikeItemModel>)
    case storiesForYou(StoriesForYouAction<StoriesForYouProps>)
    case promo(PromoAction)
    
    case newFromNike(NewFromNikeAction)
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

// Create case ...Cells(model: ...) and case .....Buttons for StoriesForYouAction and PromoAction
public enum StoriesForYouAction<Item> {
    case headerButton
    case bottomButton
//    case storySelected(models: [StoriesForYou])
    case storySelected([StoriesForYou])
//    case storySelected
}

//enum StoriesForYouAction {
//    case tappedLarge
//    case tappedSmall1
//    case tappedSmall2
//    case tappedHeader
//    case tappedBottom
//}

public enum PromoAction {
    case didTap(model: Product)
}


public struct NewFromNikeSectionViewData {

    public let header: Header
    public let rows: [NewFromNikeRowProps]
}

public struct NewFromNikeRowProps {

    public enum Content {
        case video(url: URL)
        case product(ProductProps)
    }

    public let content: Content
    public let height: CGFloat
    public let addGradient: Bool
}

public struct ProductProps {

    public let image: String
    public let logoTitle: String
    public let productData: [Product]
    public let completeTheLookHeader: CompleteTheLookHeader
    public let completeTheLookModel: [CompleteTheLookModel]
}

public extension NewFromNikeRowProps {
    func toModel() -> NewFromNikeModel {
        switch content {
        case .video(let url):
            return NewFromNikeModel(
                videoURL: url.absoluteString,
                image: nil,
                logoTitle: nil,
                detailImage: nil,
                title: nil,
                description: nil,
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
                description: nil,
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
