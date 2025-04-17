//
//  OrdersService.swift
//  LagomStore
//
//  Created by Александр Милейчик on 12/13/24.
//

import UIKit

protocol FavoritesServiceProtocol: AnyObject {
    func fetchTopPicks() -> [SubCategoryModel]
    func saveAndAdd(_ products: [SubCategoryModel])
    func printtopPickStorage()
    func fetch() -> [SubCategoryModel]
    func save(_ newTopPicks: [SubCategoryModel])
    func delete(_ product: SubCategoryModel) -> [SubCategoryModel]
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double
    func calculateTotalPriceForSecondSection() -> Double
}

class FavoritesService: FavoritesServiceProtocol {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var subCategories = "SubCategories"
    
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
            UserDefaults.standard.set(data, forKey: subCategories)
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func save(_ newTopPicks: [SubCategoryModel]) {
        do {
            let data = try encoder.encode(newTopPicks)
            UserDefaults.standard.set(data, forKey: subCategories)
            
        } catch {
            print(error)
            print("Failed to save: \(error)")
        }
    }
    
    func fetch() -> [SubCategoryModel] {
        guard let data = UserDefaults.standard.data(forKey: subCategories) else { return [] }
        
        do {
            let array = try decoder.decode([SubCategoryModel].self, from: data)
            array.forEach { 
            print("Fetched SubCategory ID: \($0.id ?? 0)") }
            return array
        } catch {
            print(error)
        }
        
        return []
    }
    
    func fetchTopPicks() -> [SubCategoryModel] {
        
        guard let data = UserDefaults.standard.data(forKey: subCategories) else {
            print("No data found for key: \(subCategories)")
            return []
        }
        do {
            let topPicks = try JSONDecoder().decode([SubCategoryModel].self, from: data)
            print("Saved successfully for key: \(subCategories)")
            return topPicks
            
        } catch {
            print("Failed to decode Top Picks: \(error)")
            return []
        }
    }
    
//MARK: - Delete
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
    func calculateTotalPriceForSecondSection() -> Double {
        let products = fetchTopPicks()
        var totalPrice = 0.0
        
        for product in products {
            totalPrice += calculateTotalSectionPrice(for: product)
        }
        
        return totalPrice
    }
}






