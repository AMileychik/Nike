//
//  ImageView.swift
//  Nike
//
//  Created by Александр Милейчик on 10/23/24.
//

import UIKit

enum ImageViewType {
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

class ImageView: UIImageView {
    
    init(type: ImageViewType) {
        super.init(frame: .zero)
        commonInit(type)
    }
    
    func commonInit(_ type: ImageViewType) {
        switch type {
            
        case .common:
            translatesAutoresizingMaskIntoConstraints = false
            contentMode = .scaleAspectFill
            clipsToBounds = true
            
        case .smallSquare:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 100).isActive = true
            widthAnchor.constraint(equalToConstant: 100).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
            
        case .favorite:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 150).isActive = true
            widthAnchor.constraint(equalToConstant: 250).isActive = true
            
        case .thankYou:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            alpha = 0.9
            
        case .newThisWeek:
            translatesAutoresizingMaskIntoConstraints = false
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 150).isActive = true
            widthAnchor.constraint(equalToConstant: 245).isActive = true
            
        case .recentlyViewed:
            translatesAutoresizingMaskIntoConstraints = false
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 150).isActive = true
            widthAnchor.constraint(equalToConstant: 150).isActive = true
            
        case .nearbySection:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 275).isActive = true
            widthAnchor.constraint(equalToConstant: 275).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
            
        case .alwaysPopular:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            layer.cornerRadius = 10
            isUserInteractionEnabled = true
            translatesAutoresizingMaskIntoConstraints = false
            
        case .pageControl:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            widthAnchor.constraint(equalToConstant: 125).isActive = true
            
        case .product:
            translatesAutoresizingMaskIntoConstraints = false
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 200).isActive = true
            widthAnchor.constraint(equalToConstant: 150).isActive = true
            
        case .mediumSquareCell:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 250).isActive = true
            widthAnchor.constraint(equalToConstant: 250).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
            
        case .size:
            contentMode = .scaleAspectFill
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            widthAnchor.constraint(equalToConstant: 100).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
            
        case .completeTheLook:
            contentMode = .scaleAspectFit
            clipsToBounds = true
            heightAnchor.constraint(equalToConstant: 375).isActive = true
            widthAnchor.constraint(equalToConstant: 300).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

