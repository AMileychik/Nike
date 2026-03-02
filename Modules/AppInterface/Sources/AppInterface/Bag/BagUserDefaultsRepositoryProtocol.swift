//
//  BagUserDefaultsRepositoryProtocol.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import AppDomain

public protocol BagUserDefaultsRepositoryProtocol {
    func fetchItems() -> [SubCategoryModel]
    func saveItems(_ items: [SubCategoryModel])
    func deleteItem(_ item: SubCategoryModel)
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double
    func calculateTotalPrice() -> Double
}
