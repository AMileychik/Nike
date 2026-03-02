//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//


import Foundation
import AppDomain

// MARK: - PromoProvider

/// Provider responsible for building the "Promo" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of the promo section.
/// - Builds a `HomeSectionModel` from `promo` data in the Home API response.
public struct PromoProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = HomeSectionPriority.promo
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the "Promo" section from API response.
    ///
    /// - Parameter response: Raw Home API response.
    /// - Returns: A `HomeSectionModel` representing the section, or `nil` if no promo items exist.
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        // Return nil if there are no promo items
        guard !response.promo.isEmpty else { return nil }
        
        let model = PromoSectionModel(products: response.promo)
        
        return HomeSectionModel(
            type: .promo,
            data: .promo(model)
        )
    }
}

