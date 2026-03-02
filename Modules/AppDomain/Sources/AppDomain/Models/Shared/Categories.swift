//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct Categories: Codable {
    public let id: Int?
    public let categoryImage: String?
    public let subCategories: [SubCategoryModel]?
    
    public init(id: Int?, categoryImage: String?, subCategories: [SubCategoryModel]?) {
        self.id = id
        self.categoryImage = categoryImage
        self.subCategories = subCategories
    }
}
