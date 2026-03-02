//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//

import AppDomain

// MARK: - StoriesForYouMapper

/// Maps `StoriesForYou` domain models into UI-ready `StoriesForYouProps`.
///
/// Responsibilities:
/// - Converts each `StoriesForYou` item into a presentation model for the Stories section.
public final class StoriesForYouMapper: StoriesForYouMapperProtocol {
    
    // MARK: - Initialization
    
    /// Default initializer.
    public init() {}
    
    // MARK: - Mapping
    
    /// Maps a `StoriesForYou` domain model into UI-ready props.
    ///
    /// - Parameter model: The domain model to map.
    /// - Returns: A `StoriesForYouProps` instance for display.
    public func map(_ model: StoriesForYou) -> StoriesForYouProps {
        StoriesForYouProps(
            product: model,
            title: model.title,
            rightButtonTitle: model.rightButtonTitle,
            large: model.largeImage,
            largeImageLabel1: model.largeImageLabel1,
            small1: model.smallImage1,
            small2: model.smallImage2,
            bottomButtonTitle: model.bottomButtonTitle
        )
    }
}

