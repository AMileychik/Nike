//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/26/25.
//

import DesignSystem
import AppDomain
import AppInterface

public protocol ProductToPromoPageMapperProtocol {
    func map(_ product: Product) -> PromoPageViewData
}

public final class ProductToPromoPageMapper: ProductToPromoPageMapperProtocol {
    public init() {}

    public func map(_ product: Product) -> PromoPageViewData {
        .init(
            image: product.image ?? "",
            title: product.type ?? "",
            subtitle: product.description ?? "",
            fullDescription: product.fullDescription,
            type: product.type,
            description: product.description
        )
    }
}
