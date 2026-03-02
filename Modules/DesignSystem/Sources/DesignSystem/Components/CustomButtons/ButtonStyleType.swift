//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import UIKit
import AppCore

public struct ButtonStyleConfig {
    public let title: String
    public let backgroundColor: UIColor
    public let titleColor: UIColor
    public let iconImage: UIImage?
    public let iconSize: CGSize?
    public let font: UIFont
    public let cornerRadius: CGFloat

    public init(
        title: String,
        backgroundColor: UIColor,
        titleColor: UIColor,
        iconImage: UIImage?,
        iconSize: CGSize?,
        font: UIFont,
        cornerRadius: CGFloat
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.iconImage = iconImage
        self.iconSize = iconSize
        self.font = font
        self.cornerRadius = cornerRadius
    }
}

public enum ButtonStyleType {
    case payButton
    case checkoutButton

    public var config: ButtonStyleConfig {
        switch self {
        case .payButton:
            return ButtonStyleConfig(
                title: Text.Bag.pay,
                backgroundColor: .white,
                titleColor: .black,
                iconImage: Image.appleLogo,
                iconSize: CGSize(width: 20, height: 24),
                font: .systemFont(ofSize: 24, weight: .medium),
                cornerRadius: 22
            )
        case .checkoutButton:
            return ButtonStyleConfig(
                title: Text.Bag.checkout,
                backgroundColor: .black,
                titleColor: .white,
                iconImage: nil,
                iconSize: nil,
                font: .systemFont(ofSize: 24, weight: .medium),
                cornerRadius: 22
            )
        }
    }
}



// Temporary

//public enum Text {
//    
//    public enum TabBarController {
//        public static let home = "Home"
//        public static let shop = "Shop"
//        public static let favorite = "Favorite"
//        public static let bag = "Bag"
//        public static let profile = "Profile"
//    }
//    
//    public enum Home {
//        public static let explore = "Explore"
//    }
//    
//    public enum Bag {
//        public static let pay = "Pay"
//        public static let checkout = "Checkout"
//        public static let subtotal = "Subtotal"
//    }
//    
//    public enum QuantityPickerViewController {
//        public static let done = "Done"
//    }
//    
//    public enum Favorite {
//        public static let done = "Done"
//        public static let edit = "Edit"
//    }
//    
//    public enum Video {
//        public static let viewAll = "View All"
//    }
//    
//    public enum Detail {
//        public static let addedToBag = "Added to Bag"
//        public static let favorited = "Favorited"
//    }
//    
////    public enum ComingSoonViewControllerText {
////        public static let greatThingsTakeTime = "Great things take time"
////        public static let seeYouSoon = "See You Soon"
////    }
//}
