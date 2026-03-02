//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//


import Foundation

import AppDomain

// MARK: - StoriesProvider

/// Provider responsible for building the "Stories For You" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of this section in the Home layout.
/// - Builds a `HomeSectionModel` using `storiesForYou` data from the Home API response.
public struct StoriesProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = HomeSectionPriority.storiesForYou
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "Stories For You" section from API response.
    ///
    /// - Parameter response: The raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the section, or `nil` if no stories exist.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if there are no stories in this section
        guard !response.storiesForYou.isEmpty else { return nil }
        
        let sectionModel = StoriesForYouModel(
            header: response.storiesForYouHeader,
            products: response.storiesForYou
        )
        
        return HomeSectionModel(
            type: .storiesForYou,
            data: .storiesForYou(sectionModel)
        )
    }
}
