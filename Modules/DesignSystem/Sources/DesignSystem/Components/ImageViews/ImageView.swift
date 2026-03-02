//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

public enum ImageViewType {
    case common
    case smallSquare
    case favorite
    case thankYou
    case newThisWeek
    case recentlyViewed
    case nearbySection
    case alwaysPopular
    case pageControl
    case product
    case mediumSquareCell
    case size
    case completeTheLook
}

public class ImageView: UIImageView {
    
    public init(type: ImageViewType) {
        super.init(frame: .zero)
        commonInit(type)
    }
    
    private func commonInit(_ type: ImageViewType) {
        switch type {
        case .common:
            configureDefault()
            
        case .smallSquare:
            configureDefault()
            setSize(width: 100, height: 100)
            
        case .favorite:
            configureDefault()
            setSize(width: 250, height: 150)
            
        case .thankYou:
            configureDefault()
            alpha = 0.9
            
        case .newThisWeek:
            configureDefault()
            setSize(width: 245, height: 150)
            
        case .recentlyViewed:
            configureDefault()
            setSize(width: 150, height: 150)
            
        case .nearbySection:
            configureDefault()
            setSize(width: 275, height: 275)
            
        case .alwaysPopular:
            configureDefault()
            layer.cornerRadius = 10
            isUserInteractionEnabled = true
            
        case .pageControl:
            configureDefault()
            widthAnchor.constraint(equalToConstant: 125).isActive = true
            
        case .product:
            configureDefault()
            setSize(width: 150, height: 200)
            
        case .mediumSquareCell:
            configureDefault()
            setSize(width: 250, height: 250)
            
        case .size:
            configureDefault()
            setSize(width: 100, height: 50)
            
        case .completeTheLook:
            contentMode = .scaleAspectFit
            clipsToBounds = true
            translatesAutoresizingMaskIntoConstraints = false
            setSize(width: 300, height: 375)
        }
    }
    
    private func configureDefault() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setSize(width: CGFloat, height: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//public class ImageView: UIImageView {
//
//    private var widthConstraint: NSLayoutConstraint?
//    private var heightConstraint: NSLayoutConstraint?
//
//    public init(type: ImageViewType) {
//        super.init(frame: .zero)
//        commonInit(type)
//    }
//
//    private func commonInit(_ type: ImageViewType) {
//        contentMode = .scaleAspectFill
//        clipsToBounds = true
//        translatesAutoresizingMaskIntoConstraints = false
//
//        switch type {
//        case .product:
//            setSize(width: 150, height: 200)
//        case .mediumSquareCell:
//            setSize(width: 250, height: 250)
//        case .completeTheLook:
//            contentMode = .scaleAspectFit
//            setSize(width: 300, height: 375)
//        // ... другие типы
//        default:
//            break
//        }
//    }
//
//    private func setSize(width: CGFloat, height: CGFloat) {
//        widthConstraint?.isActive = false
//        heightConstraint?.isActive = false
//
//        widthConstraint = widthAnchor.constraint(equalToConstant: width)
//        heightConstraint = heightAnchor.constraint(equalToConstant: height)
//
//        widthConstraint?.isActive = true
//        heightConstraint?.isActive = true
//    }
//
//    public func updateSize(width: CGFloat, height: CGFloat) {
//        widthConstraint?.constant = width
//        heightConstraint?.constant = height
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
