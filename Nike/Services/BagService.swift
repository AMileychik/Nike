//
//  BagService.swift
//  LagomStore
//
//  Created by Александр Милейчик on 3/6/25.
//

import UIKit

protocol BagServiceProtocol: AnyObject {
    func fetchTopPicks() -> [SubCategoryModel]
    func saveAndAdd(_ products: [SubCategoryModel])
    func printtopPickStorage()
    func fetch() -> [SubCategoryModel]
    func save(_ newTopPicks: [SubCategoryModel])
    func delete(_ product: SubCategoryModel) -> [SubCategoryModel]
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double
    func calculateTotalPrice() -> Double
}

class BagService: BagServiceProtocol {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var bagKey = "BagKey"
    
    func saveAndAdd(_ newTopPicks: [SubCategoryModel]) {
        var currentTopPicks = fetch()
        
        for newPick in newTopPicks {
            if let index = currentTopPicks.firstIndex(where: { $0.id == newPick.id }) {
                currentTopPicks[index] = newPick
            } else {
                currentTopPicks.append(newPick)
            }
        }
        
        do {
            let data = try encoder.encode(currentTopPicks)
            UserDefaults.standard.set(data, forKey: bagKey)
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func save(_ newTopPicks: [SubCategoryModel]) {
        do {
            let data = try encoder.encode(newTopPicks)
            UserDefaults.standard.set(data, forKey: bagKey)
            
        } catch {
            print(error)
            print("Failed to save: \(error)")
        }
    }
    
    func fetch() -> [SubCategoryModel] {
        guard let data = UserDefaults.standard.data(forKey: bagKey) else { return [] }
        
        do {
            let array = try decoder.decode([SubCategoryModel].self, from: data)
            array.forEach { print("Fetched SubCategory ID: \($0.id ?? 0)") } // Логируем загруженные ID
            print("Saved successfully for key: \(bagKey)")
            return array
        } catch {
            print(error)
        }
        
        return []
    }
    
    func fetchTopPicks() -> [SubCategoryModel] {
        
        guard let data = UserDefaults.standard.data(forKey: bagKey) else {
            print("No data found for key: \(bagKey)")
            return []
        }
        do {
            let topPicks = try JSONDecoder().decode([SubCategoryModel].self, from: data)
            print("Saved successfully for key: \(bagKey)")
            return topPicks
            
        } catch {
            print("Failed to decode Top Picks: \(error)")
            return []
        }
    }
    
//     MARK: - Delete
    @discardableResult
    func delete(_ product: SubCategoryModel) -> [SubCategoryModel] {
        
        var products = fetch()
        print(products.count)
        products.removeAll(where: { $0.id == product.id })
        
        print(products.count)
        save(products)
        
        return products
    }
    
    func printtopPickStorage() {
        let products = fetch()
        if products.isEmpty {
            print("Storage is empty.")
        } else {
            print("Current Storage:")
            products.forEach { product in
                print("ID: \(product.id ?? 0), Name: \(product.subCategoryImage ?? "")")
            }
        }
    }
    
// MARK: - CalculateTotalSectionPrice
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double {
        guard let price = model.price, let count = model.count else {
            return 0
        }
        return price * count
    }
    
// MARK: - CalculateTotalPriceForSecondSection
    func calculateTotalPrice() -> Double {
        let products = fetchTopPicks()
        var totalPrice = 0.0
        
        for product in products {
            totalPrice += calculateTotalSectionPrice(for: product)
        }
        
        return totalPrice
    }
}
