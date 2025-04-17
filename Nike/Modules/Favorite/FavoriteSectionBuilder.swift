//
//  FavoriteSectionBuilder.swift
//  LagomStore
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

final class FavoriteSectionBuilder {
    
    static func createFavoriteSections(from products: [SubCategoryModel]) -> [FavoriteSection] {
        return [
            .favorites(model: products)
        ]
    }
}
