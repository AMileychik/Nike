//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//

import AppDomain

public final class ProductToBecauseYouLikeMapper: ProductToBecauseYouLikeMapperProtocol {
    
    public init() {}
    
    public func map(_ product: Product) -> AnyItemModel {
        .init(
            product: product,
            title: product.type ?? "",
            subtitle: product.description,
            imageURL: product.image ?? product.image2,
            priceLabel: product.price
        )
    }
    
    public func mapToDomain(_ item: AnyItemProtocol) -> TopPickSelection {
      
        guard let item = item as? AnyItemModel else {
                    fatalError("Unsupported item type")
                }
        
        let product = item.product
        return TopPickSelection(
            products: [product],
            categories: product.categories?.first ?? Categories(id: nil, categoryImage: "", subCategories: []),
            header: product.header,
            category: product.categoryName ?? "",
            subCategory: product.categories?.first?.subCategories?.first ?? SubCategoryModel(id: nil, subCategoryImage: "", title: "", category: "", count: nil, price: nil, isHeartFilled: nil)
        )
    }
}

