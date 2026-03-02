//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

public final class BagSectionBuilder {
    public static func createBagSections(from products: [BagProductUIModel], totalPrice: Double) -> [BagSections] {
        [
            .products(products),
            .totalPrice(totalPrice)
        ]
    }
}

// Implement providers
