//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/10/25.
//

import UIKit

import AppDomain
import DesignSystem

/// Factory responsible for creating Home table view cells using registered builders.
public final class HomeCellFactory: HomeCellFactoryProtocol {
    
    // MARK: - Properties
    
    private let registry: HomeCellBuilderRegistryProtocol
    private let featureSectionBuilder: HomeFeatureSectionBuildingProtocol
    
    /// Initializes the factory with a cell builder registry.
    /// - Parameter registry: Registry containing builders for each section type.
    init(
        registry: HomeCellBuilderRegistryProtocol,
        featureSectionBuilder: HomeFeatureSectionBuildingProtocol
    ) {
        self.registry = registry
        self.featureSectionBuilder = featureSectionBuilder
    }
    
    /// Creates a UITableViewCell for a given section.
    /// - Parameters:
    ///   - tableView: The UITableView to dequeue the cell in.
    ///   - indexPath: The IndexPath for the cell.
    ///   - section: The HomeSectionModel containing data and type.
    ///   - actionHandler: Handler for cell actions.
    /// - Returns: A configured UITableViewCell.
    public func makeCell(
        tableView: UITableView,
        indexPath: IndexPath,
        section: HomeSectionModel,
        actionHandler: HomeCellActionHandlerProtocol
    ) -> UITableViewCell {
        
        let featureSection = featureSectionBuilder.build(from: section)
        
        return registry.builder(for: section.type)
            .buildCell(
                in: tableView,
                indexPath: indexPath,
                section: featureSection,
                actionHandler: actionHandler
            )
    }
}

//✅ Правильный баланс (как в больших командах)
//
//Вводим правило:
//    •    Сложные / переиспользуемые секции → SectionBuilder
//    •    Простые / одноразовые секции → inline
//
//switch section {
//case .promo:
//    return promoBuilder.build(...)
//    
//case .becauseYouLike:
//    return becauseYouLikeBuilder.build(...)
//    
//case .emptyState:
//    return EmptyStateCell(model: section.model)
//}
//
//but i have a dictionary
