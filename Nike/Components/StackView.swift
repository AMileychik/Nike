//
//  StackView.swift
//  Nike
//
//  Created by Александр Милейчик on 10/23/24.
//

import UIKit

enum StackViewType {
    case productCell
    case headerStackView
    case newAndFeatured
    case listHeader
}

class StackView: UIStackView {
    
    init(type: StackViewType) {
        super.init(frame: .zero)
        commonInit(type)
    }
    
    func commonInit(_ type: StackViewType) {
        switch type {
            
        case .productCell:
            axis = .vertical
            spacing = Layout.offset6
            distribution = .fill
            alignment = .leading
            
            directionalLayoutMargins = NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0)
            isLayoutMarginsRelativeArrangement = true
            backgroundColor = .systemBackground
            translatesAutoresizingMaskIntoConstraints = false
            
        case .headerStackView:
            translatesAutoresizingMaskIntoConstraints = false
            axis = .vertical
            alignment = .top
            spacing = -6
            distribution = .fillEqually
            
        case .newAndFeatured:
            axis = .vertical
            alignment = .leading
            spacing = 4
            translatesAutoresizingMaskIntoConstraints = false
            
        case .listHeader:
            translatesAutoresizingMaskIntoConstraints = false
            axis = .horizontal
            distribution = .equalSpacing
            alignment = .center
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

