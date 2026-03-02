//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct TopPickSelection {
    public let products: [Product]
    public let categories: Categories?
    public let header: Header?
    public let category: String
    public let subCategory: SubCategoryModel?
    
    public init(
        products: [Product],
        categories: Categories?,
        header: Header?,
        category: String,
        subCategory: SubCategoryModel?
    ) {
        self.products = products
        self.categories = categories
        self.header = header
        self.category = category
        self.subCategory = subCategory
    }
}
