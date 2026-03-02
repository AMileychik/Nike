//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//


import Foundation
import AppDomain

// MARK: - NikeTrainingProvider

/// Provider responsible for building the "Nike Training" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of the Nike Training section.
/// - Builds a `HomeSectionModel` from `nikeTraining` data in the Home API response.
public struct NikeTrainingProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = 4
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "Nike Training" section from API response.
    ///
    /// - Parameter response: Raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the section, or `nil` if no Nike Training items exist.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if there are no Nike Training items
        guard !response.nikeTraining.isEmpty else { return nil }
        
        let model = BecauseYouLikeModel(
            header: response.nikeTrainingHeader,
            products: response.nikeTraining
        )
        
        return HomeSectionModel(
            type: .becauseYouLike,
            data: .becauseYouLike(model)
        )
    }
}
