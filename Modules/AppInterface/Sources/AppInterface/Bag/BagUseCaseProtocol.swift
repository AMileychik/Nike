//
//  BagUseCaseProtocol.swift
//  BagApplication
//
//
//  Created by Александр Милейчик on 6/20/25.

import Foundation
import AppDomain

public protocol BagUseCaseProtocol {
    func fetchBagItems() -> [SubCategoryModel]
    func calculateTotalPrice() -> Double
    func deleteItem(_ model: SubCategoryModel)

    func saveFavorite(_ model: SubCategoryModel)
    func updateItem(_ model: SubCategoryModel)
}
