//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/22/25.
//

import UIKit

import AppDomain
import DesignSystem

// MARK: - HomeCellBuilderRegistryError

/// Errors that can occur when working with `HomeCellBuilderRegistry`.
enum HomeCellBuilderRegistryError: Error {
    /// Triggered when no builder is registered for a given section.
    case builderNotFound(section: HomeSections)
}

// MARK: - HomeCellBuilderRegistry
///
/// Registry for Home screen cell builders.
/// - Holds a mapping of `HomeSections` to corresponding cell builders.
/// - Provides a builder for a given section or triggers an assertion if none is found.
/// - Centralizes cell builder management to simplify adding new sections.
final class HomeCellBuilderRegistry: HomeCellBuilderRegistryProtocol {

    // MARK: - Properties
    
    /// Dictionary mapping Home sections to their respective cell builders.
    private let builders: [HomeSections: HomeCellBuilding]

    // MARK: - Initialization
    
    /// Initializes the registry with a mapping of sections to builders.
    /// - Parameter builders: Dictionary of section -> cell builder.
    init(
        builders: [HomeSections: HomeCellBuilding]
    ) {
        self.builders = builders
    }

    // MARK: - Public API
    
    /// Returns a cell builder for the specified section.
    func builder(for section: HomeSections) -> HomeCellBuilding {
        return builders[section] ?? handleMissingBuilder(for: section)
    }

    // MARK: - Private Helpers
    
    /// Handles a missing builder scenario.
    private func handleMissingBuilder(for section: HomeSections) -> HomeCellBuilding {
        assertionFailure("No CellBuilder registered for section: \(section)")
        return EmptyCellBuilder()
    }
}

