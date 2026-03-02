//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/26/25.
//

import DesignSystem
import AppDomain
import AppInterface

// MARK: - ProductToPromoPageMapper

/// Maps `Product` domain models to UI-ready `PromoPageViewData` for the Promo section.
///
/// Responsibilities:
/// - Converts `Product` into `PromoPageViewData` for display in the Promo carousel.
public final class ProductToPromoPageMapper: ProductToPromoPageMapperProtocol {
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - Mapping
    
    /// Maps a `Product` domain model into a UI model (`PromoPageViewData`).
    ///
    /// - Parameter product: The product to map.
    /// - Returns: A UI-ready `PromoPageViewData`.
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
