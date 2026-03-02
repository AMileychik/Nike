//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//


import Foundation
import AppDomain

// MARK: - ThankYouProvider

/// Provider responsible for building the "Thank You" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of this section in the Home layout.
/// - Builds a `HomeSectionModel` using `thankYou` data from the Home API response.
public struct ThankYouProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = HomeSectionPriority.thankYou
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "Thank You" section from API response.
    ///
    /// - Parameter response: The raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the section, or `nil` if no data exists.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if the section has no data
        guard !response.thankYou.image.isEmpty else { return nil }

        return HomeSectionModel(
            type: .thankYou,
            data: .thankYou(response.thankYou)
        )
    }
}
