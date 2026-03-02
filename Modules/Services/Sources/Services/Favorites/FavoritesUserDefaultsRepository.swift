//
//  FavoritesUserDefaultsRepository.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation
import AppDomain
import AppInterface

public final class FavoritesUserDefaultsRepository: FavoritesUserDefaultsRepositoryProtocol {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let favoriteKey = "FavoriteKey"

    public init() {}

    public func fetchItems() -> [SubCategoryModel] {
        guard let data = UserDefaults.standard.data(forKey: favoriteKey) else { return [] }
        do {
            return try decoder.decode([SubCategoryModel].self, from: data)
        } catch {
            print("Failed to decode favorites: \(error)")
            return []
        }
    }

    public func saveItems(_ items: [SubCategoryModel]) {
        do {
            let data = try encoder.encode(items)
            UserDefaults.standard.set(data, forKey: favoriteKey)
        } catch {
            print("Failed to save favorites: \(error)")
        }
    }

    public func deleteItem(_ item: SubCategoryModel) -> [SubCategoryModel] {
        var items = fetchItems()
        items.removeAll(where: { $0.id == item.id })
        saveItems(items)
        return items
    }

    public func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double {
        guard let price = model.price, let count = model.count else { return 0 }
        return price * count
    }

    public func calculateTotalPrice() -> Double {
        let items = fetchItems()
        return items.reduce(0) { $0 + calculateTotalSectionPrice(for: $1) }
    }
}
