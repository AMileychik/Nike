//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/21/25.
//


import UIKit
import AppDomain
import DesignSystem

// MARK: - CarouselContainerBuilder

/// Builder responsible for constructing a "Because You Like" carousel cell
/// in the Home screen table view.
///
/// Responsibilities:
/// - Dequeues and configures a `CarouselContainer` cell.
/// - Sets up the header button using the provided `HomeUIComponentsFactoryProtocol`.
/// - Maps `HomeFeatureSection` data into a `CarouselContainerSection`.
/// - Attaches the `actionHandler` closure to handle user interactions.
final class CarouselContainerBuilder: HomeCellBuilding {

    // MARK: - Dependencies

    /// Factory for creating UI components for Home cells.
    private let uiFactory: HomeUIComponentsFactoryProtocol

    // MARK: - Initialization

    /// Initializes the builder with a UI factory.
    ///
    /// - Parameter uiFactory: Factory responsible for creating reusable UI components.
    init(uiFactory: HomeUIComponentsFactoryProtocol) {
        self.uiFactory = uiFactory
    }

    // MARK: - HomeCellBuilding

    /// Builds and configures a `CarouselContainer` cell for the "Because You Like" section.
    ///
    /// - Parameters:
    ///   - tableView: The table view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - section: The `HomeFeatureSection` containing the data for this cell.
    ///   - actionHandler: Optional handler for cell actions (e.g., taps on items or header).
    /// - Returns: A fully configured `UITableViewCell`.
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {

        // Ensure this builder only handles "Because You Like" sections
        guard case .becauseYouLike(let viewData) = section else {
            return UITableViewCell()
        }

        // Dequeue a reusable carousel cell
        let cell: CarouselContainerDefaultCell = tableView.dequeueCell(indexPath)

        // Create and assign the header button
        let headerButton = uiFactory.makeHeaderButton()
        cell.setHeaderButton(headerButton)

        // Map view data into a carousel section
        let carouselSection = CarouselContainerSection(
            header: viewData.header,
            items: viewData.items
        )
        cell.configure(with: carouselSection)

        // Attach action handler to propagate cell actions
        cell.onAction = { [weak actionHandler] action in
            actionHandler?.handle(action, at: indexPath)
        }

        return cell
    }
}

typealias CarouselContainerDefaultCell = CarouselContainer<AnyItemModel, Header>

