//
//  BagSection.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

public enum BagSections {
    case products([BagProductUIModel])
    case totalPrice(Double)
}

public extension BagSections {
    var type: BagSectionType {
        switch self {
            
        case .products:
            return .products
            
        case .totalPrice:
            return .totalPrice
        }
    }
}
