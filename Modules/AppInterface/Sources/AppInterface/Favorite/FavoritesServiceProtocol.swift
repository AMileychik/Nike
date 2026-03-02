//
//  FavoritesServiceProtocol.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation
import AppDomain

public protocol FavoritesServiceProtocol: AnyObject {
    var repository: FavoritesUserDefaultsRepositoryProtocol { get }
    
    func fetchTopPicks() -> [SubCategoryModel]
    func fetch() -> [SubCategoryModel]
    func saveAndAdd(_ products: [SubCategoryModel])
    func save(_ products: [SubCategoryModel])
    func delete(_ product: SubCategoryModel) -> [SubCategoryModel]
    func printTopPickStorage()
    func calculateTotalSectionPrice(for model: SubCategoryModel) -> Double
    func calculateTotalPrice() -> Double
}


