//
//  BagServiceProtocol.swift
//
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import AppDomain

public protocol BagServiceProtocol: AnyObject {
    var repository: BagUserDefaultsRepositoryProtocol { get }

    func fetch() -> [SubCategoryModel]
    func saveAndAdd(_ products: [SubCategoryModel])
    func save(_ products: [SubCategoryModel])
    func delete(_ product: SubCategoryModel)
    func printStorage()
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double
    func calculateTotalPrice() -> Double
    func update(_ model: SubCategoryModel)
}
