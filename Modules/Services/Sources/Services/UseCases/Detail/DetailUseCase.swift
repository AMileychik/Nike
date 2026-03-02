//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/4/25.
//

import AppInterface
import AppDomain

public final class DetailUseCase: DetailUseCaseProtocol {

    private let bagService: BagServiceProtocol
    private let favoriteService: FavoritesServiceProtocol

    public init(bagService: BagServiceProtocol, favoriteService: FavoritesServiceProtocol) {
        self.bagService = bagService
        self.favoriteService = favoriteService
    }
    
    public func saveAndAddToBag(_ products: [SubCategoryModel]) {
        bagService.saveAndAdd(products)
    }
    
    public func saveAndAddToFavorite(_ products: [SubCategoryModel]) {
        favoriteService.saveAndAdd(products)
    }
}
