//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/22/25.
//

import UIKit

import AppDomain
import DesignSystem

enum HomeCellBuilderRegistryError: Error {
    case builderNotFound(section: HomeSections)
}

// MARK: - HomeCellBuilderRegistry

/// Registry for Home screen cell builders.
///
/// - Centralizes management of cell builders for each `HomeSections` case.
final class HomeCellBuilderRegistry: HomeCellBuilderRegistryProtocol {

    // MARK: - Properties
    
    /// Dictionary mapping Home sections to their respective cell builders.
    private let builders: [HomeSections: HomeCellBuilding]

    // MARK: - Initialization
    
    /// Initializes the registry with a mapping of sections to builders.
    ///
    /// - Parameter builders: Dictionary mapping each `HomeSections` case to its `HomeCellBuilding` instance.
    init(builders: [HomeSections: HomeCellBuilding]) {
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

