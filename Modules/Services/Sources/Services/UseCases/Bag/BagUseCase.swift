//
//  BagUseCaseImpl.swift
//  BagApplication
//
//  Created by Александр Милейчик on 6/20/25.

import AppInterface
import AppDomain

public final class BagUseCase: BagUseCaseProtocol {

    private let bagService: BagServiceProtocol
    private let favoriteService: FavoritesServiceProtocol

    public init(bagService: BagServiceProtocol, favoriteService: FavoritesServiceProtocol) {
        self.bagService = bagService
        self.favoriteService = favoriteService
    }

    public func fetchBagItems() -> [SubCategoryModel] {
        bagService.fetch()
    }

    public func calculateTotalPrice() -> Double {
        bagService.calculateTotalPrice()
    }

    public func deleteItem(_ model: SubCategoryModel) {
        bagService.delete(model)
    }


    public func updateItem(_ model: SubCategoryModel) {
        bagService.update(model)
    }

    public func saveFavorite(_ model: SubCategoryModel) {
        favoriteService.saveAndAdd([model])
    }
}
