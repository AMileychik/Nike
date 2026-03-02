//
//  BagService.swift
//
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import AppInterface
import AppDomain

public final class BagService: BagServiceProtocol {

    public let repository: BagUserDefaultsRepositoryProtocol

    public init(repository: BagUserDefaultsRepositoryProtocol) {
        self.repository = repository
    }

    public func fetch() -> [SubCategoryModel] {
        repository.fetchItems()
    }

    public func saveAndAdd(_ products: [SubCategoryModel]) {
        var current = fetch()
        for newPick in products {
            if let index = current.firstIndex(where: { $0.id == newPick.id }) {
                current[index] = newPick
            } else {
                current.append(newPick)
            }
        }
        repository.saveItems(current)
    }

    public func save(_ products: [SubCategoryModel]) {
        repository.saveItems(products)
    }

    public func delete(_ product: SubCategoryModel) {
        repository.deleteItem(product)
    }
    

    public func printStorage() {
        let products = fetch()
        if products.isEmpty {
            print("Storage is empty.")
        } else {
            print("Current Storage:")
            products.forEach { print("ID: \($0.id ?? 0), Name: \($0.subCategoryImage ?? "")") }
        }
    }

    public func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double {
        repository.calculateTotalSectionPrice(for: model)
    }

    public func calculateTotalPrice() -> Double {
        repository.calculateTotalPrice()
    }

    public func update(_ model: SubCategoryModel) {
        var current = fetch()
        guard let index = current.firstIndex(where: { $0.id == model.id }) else { return }
        current[index] = model
        repository.saveItems(current)
    }
}

