//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/10/25.
//

import UIKit

import AppDomain
import DesignSystem

// MARK: - HomeCellFactory
///
/// Responsible for creating table view cells for the Home screen.
/// Uses a registry of section-specific builders and a feature section builder to configure each cell.
/// This allows decoupling cell creation from the table view and centralizes all cell configuration logic.

public final class HomeCellFactory: HomeCellFactoryProtocol {
    
    // MARK: - Properties
    
    /// Registry containing builders for each Home section type.
    private let registry: HomeCellBuilderRegistryProtocol
    
    /// Builder that transforms a section model into a feature-ready section for cells.
    private let featureSectionBuilder: HomeFeatureSectionBuildingProtocol
    
    // MARK: - Initialization
    
    init(
        registry: HomeCellBuilderRegistryProtocol,
        featureSectionBuilder: HomeFeatureSectionBuildingProtocol
    ) {
        self.registry = registry
        self.featureSectionBuilder = featureSectionBuilder
    }
    
    // MARK: - Public API
    
    /// Creates a UITableViewCell for a given section and indexPath.
    public func makeCell(
        tableView: UITableView,
        indexPath: IndexPath,
        section: HomeSectionModel,
        actionHandler: HomeCellActionHandlerProtocol
    ) -> UITableViewCell {
        
        // Transform the section model into a feature-ready section for cell builders
        let featureSection = featureSectionBuilder.build(from: section)
        
        // Use the appropriate builder from the registry to create the cell
        return registry.builder(for: section.type)
            .buildCell(
                in: tableView,
                indexPath: indexPath,
                section: featureSection,
                actionHandler: actionHandler
            )
    }
}
