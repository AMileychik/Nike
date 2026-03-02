//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//


import UIKit
import AppDomain
import AppInterface

// MARK: - ThankYouSectionMapper

/// Maps `ThankYouSectionModel` domain model into UI-ready `ThankYouViewData`.
///
/// Responsibilities:
/// - Converts the Thank You section domain model into a presentation model suitable for UI display.
public final class ThankYouSectionMapper: ThankYouSectionMapperProtocol {
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - Mapping
    
    /// Maps a `ThankYouSectionModel` to `ThankYouViewData`.
    ///
    /// - Parameter model: The domain model containing Thank You section data.
    /// - Returns: A `ThankYouViewData` instance ready for display.
    public func map(_ model: ThankYouSectionModel) -> ThankYouViewData {
        ThankYouViewData(image: UIImage(named: model.image))
    }
}

