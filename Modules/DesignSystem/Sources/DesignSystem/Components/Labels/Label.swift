//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

public enum LabelType {
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

public class Label: InsetLabel {
    
    public init(type: LabelType) {
        super.init(frame: .zero)
        commonInit(type)
    }
    
    private func commonInit(_ type: LabelType) {
        switch type {
        case .screenTitle:
            font = UIFont.systemFont(ofSize: 24, weight: .medium)
            textColor = UIColor(white: 0.1, alpha: 1)

        case .titleDescription:
            font = UIFont.systemFont(ofSize: 16, weight: .medium)
            textColor = UIColor(white: 0.4, alpha: 1)

        case .subTitleDescription:
            font = UIFont.systemFont(ofSize: 16, weight: .medium)
            textColor = UIColor(white: 0.1, alpha: 1)

        case .price:
            font = UIFont.boldSystemFont(ofSize: 15)
            backgroundColor = .lightGray.withAlphaComponent(0.5)
            contentInset = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
            layer.cornerRadius = 16
            clipsToBounds = true

        case .priceLabel:
            font = UIFont.systemFont(ofSize: 14)

        case .banner:
            font = UIFont.systemFont(ofSize: 16, weight: .bold)

        case .title:
            font = UIFont.systemFont(ofSize: 16, weight: .bold)

        case .subtitle:
            font = UIFont.systemFont(ofSize: 14, weight: .regular)

        case .alwaysPopular:
            textColor = .white
            font = UIFont.systemFont(ofSize: 13)

        case .alwaysPopularBoltWeight:
            textColor = .white
            font = UIFont.systemFont(ofSize: 14, weight: .bold)

        case .header:
            font = UIFont.systemFont(ofSize: 20, weight: .medium)
            textColor = UIColor(white: 0.1, alpha: 1)

        case .headerDescriptionLabel:
            font = UIFont.systemFont(ofSize: 20, weight: .medium)
            textColor = UIColor(white: 0.4, alpha: 1)

        case .highlighted:
            font = UIFont.systemFont(ofSize: 36, weight: .bold)
            textColor = UIColor(red: 1.0, green: 1.0, blue: 0.2, alpha: 1.0)
        }
        
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
