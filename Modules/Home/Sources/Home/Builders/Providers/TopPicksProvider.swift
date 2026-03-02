//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//


import Foundation
import AppDomain

// MARK: - TopPicksProvider

/// Provider responsible for building the "Top Picks" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of this section in the Home layout.
/// - Builds a `HomeSectionModel` using `topPicks` data from the Home API response.
public struct TopPicksProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = HomeSectionPriority.becauseYouLike
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "Top Picks" section from API response.
    ///
    /// - Parameter response: The raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the Top Picks section, or `nil` if no data is available.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if there are no Top Picks
        guard !response.topPicks.isEmpty else { return nil }
        
        // Build the section model with header and products
        let model = BecauseYouLikeModel(
            header: response.topPicksHeader,
            products: response.topPicks
        )
        
        return HomeSectionModel(
            type: .becauseYouLike,
            data: .becauseYouLike(model)
        )
    }
}


