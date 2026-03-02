//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/4/25.
//

import AppDomain

public protocol DetailUseCaseProtocol {
    func saveAndAddToBag(_ products: [SubCategoryModel])
    func saveAndAddToFavorite(_ products: [SubCategoryModel])
}
