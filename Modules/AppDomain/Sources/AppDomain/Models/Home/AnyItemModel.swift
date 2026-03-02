//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/30/25.
//

import Foundation

import AppDomain

public struct AnyItemModel: AnyItemProtocol {
    public let product: Product
    public let title: String
    public let subtitle: String?
    public let imageURL: String?
    public let priceLabel: Int?
    
    public init(
        product: Product,
        title: String,
        subtitle: String?,
        imageURL: String?,
        priceLabel: Int?
    ) {
        self.product = product
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.priceLabel = priceLabel
    }
}

public extension AnyItemModel {
    func toTopPickSelection() -> TopPickSelection {
        let product = self.product
        return TopPickSelection(
            products: [product],
            categories: product.categories?.first ?? Categories(id: nil, categoryImage: "", subCategories: []),
            header: product.header,
            category: product.categoryName ?? "",
            subCategory: product.categories?.first?.subCategories?.first ?? SubCategoryModel(
                id: nil,
                subCategoryImage: "",
                title: "",
                category: "",
                count: nil,
                price: nil,
                isHeartFilled: nil
            )
        )
    }
}
