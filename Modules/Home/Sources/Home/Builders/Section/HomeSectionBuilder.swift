//
//  HomeSectionBuilder.swift
//  Nike
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

import AppDomain

// MARK: - HomeSectionBuilder
///
/// Builds all Home sections using registered providers.
/// Each provider is responsible for constructing a specific section type.
public final class HomeSectionBuilder: HomeSectionBuildingProtocol {
    
    // MARK: - Dependencies
    
    private let providers: [HomeSectionProviderProtocol]
    
    // MARK: - Initialization

    public init(providers: [HomeSectionProviderProtocol]) {
        self.providers = providers
    }
    
    // MARK: - Public
    
    /// Builds sections from the API response.
    /// - Parameter response: Raw Home API response.
    /// - Returns: UI-ready Home sections sorted by provider priority.
    public func buildSections(from response: HomeSectionsResponse) -> [HomeSectionModel] {
        providers
            .sorted { $0.priority < $1.priority }     // Ensure consistent order of sections
            .compactMap { $0.makeSection(from: response) } // Build each section if possible
    }
}

