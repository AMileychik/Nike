//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation
import AppDomain

// MARK: - WelcomeProvider

/// Provider responsible for building the "Welcome" section on the Home screen.
///
/// Responsibilities:
/// - Determines the priority of the section in the Home screen layout.
/// - Builds a `HomeSectionModel` for the welcome section using current context (e.g., time of day).
public struct WelcomeProvider: HomeSectionProviderProtocol {
    
    // MARK: - Priority
    
    /// Determines the order of this section relative to other Home sections.
    /// Lower values appear earlier on the screen.
    public let priority = HomeSectionPriority.welcome
    
    // MARK: - Initialization
    
    /// Default initializer
    public init() {}
    
    // MARK: - HomeSectionProviderProtocol
    
    /// Builds a `HomeSectionModel` for the welcome section from API response.
    ///
    /// - Parameter response: The raw Home API response. Not used in this provider as welcome is local.
    /// - Returns: A `HomeSectionModel` representing the welcome section.
    public func makeSection(
        from response: HomeSectionsResponse
    ) -> HomeSectionModel? {
        // Create the welcome model using current time for greeting text
        let model = WelcomeSectionModel(title: Date().welcomeText)
        
        // Wrap the model in a HomeSectionModel
        return HomeSectionModel(type: .welcome, data: .welcome(model))
    }
}
