//
//  Label.swift
//  Nike
//
//  Created by Александр Милейчик on 10/23/24.
//

import UIKit

enum LabelType {
    case screenTitle
    case titleDescription
    case subTitleDescription
    case price
    case priceLabel
    case banner
    case title
    case subtitle
    case alwaysPopular
    case alwaysPopularBoltWeight
    case header
    case headerDescriptionLabel
    case highlighted
}

class Label: InsetLabel {
    init(type: LabelType) {
        super.init(frame: .zero)
        commonInit(type)
    }
    
    func commonInit(_ type: LabelType) {
        switch type {
            
        case .screenTitle:
            font = UIFont.systemFont(ofSize: 24, weight: .medium)
            textColor = UIColor(white: 0.1, alpha: 1)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
            
        case .titleDescription:
            font = UIFont.systemFont(ofSize: 16, weight: .medium)
            textColor = UIColor(white: 0.4, alpha: 1)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
            
        case .subTitleDescription:
            font = UIFont.systemFont(ofSize: 16, weight: .medium)
            textColor = UIColor(white: 0.1, alpha: 1)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
            
        case .price:
            font = UIFont.boldSystemFont(ofSize: 15)
            backgroundColor = .lightGray.withAlphaComponent(0.5)
            contentInset = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
            layer.cornerRadius = 16
            clipsToBounds = true
            translatesAutoresizingMaskIntoConstraints = false
            
        case .priceLabel:
            font = UIFont.systemFont(ofSize: 14)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
            
        case .banner:
            font = UIFont.systemFont(ofSize: 16, weight: .bold)
            translatesAutoresizingMaskIntoConstraints = false
            numberOfLines = 0
            
        case .title:
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.systemFont(ofSize: 16, weight: .bold)
            numberOfLines = 0
            
        case .subtitle:
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.systemFont(ofSize: 14, weight: .regular)
            numberOfLines = 0
            
        case .alwaysPopular:
            numberOfLines = 0
            textColor = .white
            font = UIFont.systemFont(ofSize: 13)
            translatesAutoresizingMaskIntoConstraints = false
            
        case .alwaysPopularBoltWeight:
            numberOfLines = 0
            textColor = .white
            font = UIFont.systemFont(ofSize: 14, weight: .bold)
            translatesAutoresizingMaskIntoConstraints = false
            
        case .header:
            font = UIFont.systemFont(ofSize: 20, weight: .medium)
            textColor = UIColor(white: 0.1, alpha: 1)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
            
        case .headerDescriptionLabel:
            font = UIFont.systemFont(ofSize: 20, weight: .medium)
            textColor = UIColor(white: 0.4, alpha: 1)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
            
        case .highlighted:
            font = UIFont.systemFont(ofSize: 36, weight: .bold)
            textColor = UIColor(red: 1.0, green: 1.0, blue: 0.2, alpha: 1.0)
            numberOfLines = 0
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
