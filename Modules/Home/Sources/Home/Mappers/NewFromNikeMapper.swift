//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

import Foundation
import AppDomain
import DesignSystem

// MARK: - NewFromNikeMapper

/// Maps `NewFromNikeSectionModel` into `NewFromNikeSectionViewData` for UI presentation.
///
/// Responsibilities:
/// - Converts domain models (`NewFromNikeModel`) into UI-ready row props.
/// - Adds gradients for the last product row.
/// - Handles both video and standard product rows.
public final class NewFromNikeMapper: NewFromNikeMapperProtocol {

    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}

    // MARK: - Public API
    
    /// Maps a `NewFromNikeSectionModel` to `NewFromNikeSectionViewData`.
    ///
    /// - Parameter model: The domain model representing the "New From Nike" section.
    /// - Returns: A UI-ready section view data object containing rows.
    public func map(_ model: NewFromNikeSectionModel) -> NewFromNikeSectionViewData {
        let lastIndex = model.products.count - 1

        let rows = model.products.enumerated().compactMap { index, product in
            makeRow(for: product, isLast: index == lastIndex)
        }

        return NewFromNikeSectionViewData(
            header: model.header,
            rows: rows
        )
    }
}

// MARK: - Private Helpers

private extension NewFromNikeMapper {

    /// Builds a row for a given product.
    ///
    /// - Parameters:
    ///   - product: The product to create a row for.
    ///   - isLast: Boolean indicating if this is the last product in the section.
    /// - Returns: A `NewFromNikeRowProps` if mapping is possible, otherwise `nil`.
    func makeRow(for product: NewFromNikeModel, isLast: Bool) -> NewFromNikeRowProps? {
        if let videoRow = makeVideoRow(for: product) {
            return videoRow
        }
        return makeProductRow(for: product, addGradient: isLast)
    }

    /// Creates a video row if the product contains a video URL.
    ///
    /// - Parameter product: The product to map.
    /// - Returns: A `NewFromNikeRowProps` with video content or `nil`.
    func makeVideoRow(for product: NewFromNikeModel) -> NewFromNikeRowProps? {
        guard let video = product.videoURL else { return nil }

        return NewFromNikeRowProps(
            content: .video(
                .init(
                    videoURL: video,
                    description: product.description,
                    image: product.image
                )
            ),
            height: 250,
            addGradient: true
        )
    }

    /// Creates a standard product row.
    ///
    /// - Parameters:
    ///   - product: The product to map.
    ///   - addGradient: Boolean indicating if a gradient should be applied.
    /// - Returns: A `NewFromNikeRowProps` or `nil` if required fields are missing.
    func makeProductRow(for product: NewFromNikeModel, addGradient: Bool) -> NewFromNikeRowProps? {
        guard
            let image = product.image,
            let logoTitle = product.logoTitle,
            let description = product.description,
            let productData = product.productData,
            let header = product.completeTheLookHeader,
            let items = product.completeTheLookModel
        else { return nil }

        let props = ProductProps(
            image: image,
            logoTitle: logoTitle,
            description: description,
            productData: productData,
            completeTheLookHeader: header,
            completeTheLookModel: items
        )

        return NewFromNikeRowProps(
            content: .product(props),
            height: 500,
            addGradient: addGradient
        )
    }
}
