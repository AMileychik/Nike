//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import AppDomain
import AppInterface

public final class BagUserDefaultsRepository: BagUserDefaultsRepositoryProtocol {

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let bagKey = "BagKey"

    public init() {}

    public func fetchItems() -> [SubCategoryModel] {
        guard let data = UserDefaults.standard.data(forKey: bagKey) else { return [] }
        do {
            return try decoder.decode([SubCategoryModel].self, from: data)
        } catch {
            print("Failed to decode Bag items: \(error)")
            return []
        }
    }
    

    public func saveItems(_ items: [SubCategoryModel]) {
        do {
            let data = try encoder.encode(items)
            UserDefaults.standard.set(data, forKey: bagKey)
        } catch {
            print("Failed to save Bag items: \(error)")
        }
    }

    public func deleteItem(_ item: SubCategoryModel) {
        var items = fetchItems()
        items.removeAll(where: { $0.id == item.id })
        saveItems(items)
    }
    

    public func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double {
        guard let price = model.price, let count = model.count else { return 0 }
        return price * count
    }

    public func calculateTotalPrice() -> Double {
        let products = fetchItems()
        return products.reduce(0) { $0 + calculateTotalSectionPrice(for: $1) }
    }
}
