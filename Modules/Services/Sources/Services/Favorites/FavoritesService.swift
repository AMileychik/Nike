//
//  FavoritesService.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation
import AppDomain
import AppInterface

public final class FavoritesService: FavoritesServiceProtocol {

    public let repository: FavoritesUserDefaultsRepositoryProtocol

    public init(repository: FavoritesUserDefaultsRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchTopPicks() -> [SubCategoryModel] {
        return repository.fetchItems()
    }

    public func fetch() -> [SubCategoryModel] {
        return repository.fetchItems()
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

    public func delete(_ product: SubCategoryModel) -> [SubCategoryModel] {
        return repository.deleteItem(product)
    }

    public func printTopPickStorage() {
        let products = fetch()
        if products.isEmpty {
            print("Storage is empty.")
        } else {
            print("Current Storage:")
            products.forEach {
                print("ID: \($0.id ?? 0), Name: \($0.subCategoryImage ?? "")")
            }
        }
    }

    public func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double {
        repository.calculateTotalSectionPrice(for: model)
    }

    public func calculateTotalPrice() -> Double {
        repository.calculateTotalPrice()
    }
}

