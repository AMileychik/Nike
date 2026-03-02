//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation
import AppDomain
import AppInterface

// MARK: - WelcomeSectionMapper

/// Maps `WelcomeSectionModel` domain model into UI-ready `WelcomeViewData`.
///
/// Responsibilities:
/// - Converts the Welcome section domain model into a presentation model suitable for UI display.
public final class WelcomeSectionMapper: WelcomeSectionMapperProtocol {
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - Mapping
    
    /// Maps a `WelcomeSectionModel` to `WelcomeViewData`.
    ///
    /// - Parameter model: The domain model containing Welcome section data.
    /// - Returns: A `WelcomeViewData` instance ready for display.
    public func map(_ model: WelcomeSectionModel) -> WelcomeViewData {
        WelcomeViewData(text: model.title)
    }
}

