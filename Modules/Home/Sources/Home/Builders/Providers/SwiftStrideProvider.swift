//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation
import AppDomain

// MARK: - SwiftStrideProvider

/// Provider responsible for building the "Nike Swift & Stride" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of this section in the Home layout.
/// - Builds a `HomeSectionModel` using `nikeSwiftAndStride` data from the Home API response.
public struct SwiftStrideProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = 6
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "Nike Swift & Stride" section from API response.
    ///
    /// - Parameter response: The raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the section, or `nil` if no products exist.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if there are no products in this section
        guard !response.nikeSwiftAndStride.isEmpty else { return nil }
        
        let model = BecauseYouLikeModel(
            header: response.nikeSwiftAndStrideHeader,
            products: response.nikeSwiftAndStride
        )
        
        return HomeSectionModel(
            type: .becauseYouLike,
            data: .becauseYouLike(model)
        )
    }
}

