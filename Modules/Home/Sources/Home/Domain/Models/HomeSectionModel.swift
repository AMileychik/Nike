//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation
import AppDomain

// MARK: - SectionRepresentable

/// Protocol for objects that can represent a table section.
public protocol SectionRepresentable {
    /// Number of rows in the section.
    var numberOfRows: Int { get }
}

// MARK: - HomeSectionModel

/// Represents a single section on the Home screen.
///
/// Responsibilities:
/// - Holds the type of the section (`HomeSections`) and its payload.
/// - Conforms to `SectionRepresentable` for table view rendering.
public struct HomeSectionModel {
    
    /// The type of the Home section.
    public let type: HomeSections
    
    /// The payload containing the section data.
    public let data: HomeSectionPayload
    
    // MARK: - Initialization
    
    /// Initializes a Home section model with type and payload.
    ///
    /// - Parameters:
    ///   - type: The type of Home section.
    ///   - data: The associated payload for the section.
    public init(type: HomeSections, data: HomeSectionPayload) {
        self.type = type
        self.data = data
    }
}

// MARK: - SectionRepresentable Conformance

extension HomeSectionModel: SectionRepresentable {
    
    /// Returns the number of rows for this section.
    ///
    /// For all current Home sections, the count is 1.
    public var numberOfRows: Int {
        switch data {
        case .welcome,
             .becauseYouLike,
             .promo,
             .newFromNike,
             .thankYou,
             .storiesForYou:
            return 1
        }
    }
}

