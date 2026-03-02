//
//  FavoritesRepositoryProtocol.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation
import AppDomain

public protocol FavoritesUserDefaultsRepositoryProtocol {
    func fetchItems() -> [SubCategoryModel]
    func saveItems(_ items: [SubCategoryModel])
    func deleteItem(_ item: SubCategoryModel) -> [SubCategoryModel]
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double
    func calculateTotalPrice() -> Double
}

