//
//  BagSectionBuilder.swift
//  Nike
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

final class BagSectionBuilder {
    
    static func createBagSections(from products: [SubCategoryModel], totalPrice: Double) -> [BagSection] {
        return [
            .products(products),
            .totalPrice(totalPrice)
        ]
    }
}
