//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/15/25.
//

import Foundation

import AppDomain
import DesignSystem

// MARK: - NewFromNikeProvider

/// Provider responsible for building the "New From Nike" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of the New From Nike section.
/// - Builds a `HomeSectionModel` from `newFromNike` data in the Home API response.
public struct NewFromNikeProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = 3
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "New From Nike" section from API response.
    ///
    /// - Parameter response: Raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the section, or `nil` if no New From Nike items exist.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if there are no New From Nike items
        guard !response.newFromNike.isEmpty else { return nil }
        
        let model = NewFromNikeSectionModel(
            header: response.newFromNikeHeader,
            products: response.newFromNike
        )
        
        return HomeSectionModel(
            type: .newFromNike,
            data: .newFromNike(model)
        )
    }
}
