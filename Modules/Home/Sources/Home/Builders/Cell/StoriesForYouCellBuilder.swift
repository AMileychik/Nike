//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//


import UIKit
import AppDomain

// MARK: - StoriesForYouCellBuilder

/// Builder responsible for creating cells for the "Stories For You" section on the Home screen.
///
/// Responsibilities:
/// - Dequeues and configures `StoriesForYouCell` with view data and props.
/// - Attaches the `HomeCellActionHandlerProtocol` to handle user interactions.
final class StoriesForYouCellBuilder: HomeCellBuilding {
    
    typealias StoriesForYouDefaultCell = StoriesForYouCell<StoriesForYouProps, Header>

    // MARK: - HomeCellBuilding

    /// Builds a `StoriesForYouCell` for the specified section.
    ///
    /// - Parameters:
    ///   - tableView: The table view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - section: The `HomeFeatureSection` representing the "Stories For You" section.
    ///   - actionHandler: Optional handler for cell actions.
    /// - Returns: A fully configured `StoriesForYouCell`.
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {

        // Ensure the section is of the correct type
        guard case .storiesForYou(let model) = section else { return UITableViewCell() }

        // Dequeue the cell
        let cell: StoriesForYouDefaultCell = tableView.dequeueCell(indexPath)
        
        // Ensure there is at least one item to display
        guard let props = model.items.first else { return cell }
        
        // Build the section with header and props
        let section = StoriesForYouSection(
            header: model.header,
            props: props
        )
        
        // Update the cell with the section data
        cell.update(with: section)
        
        // Attach action handler
        cell.onAction = { [weak actionHandler] action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        return cell
    }
}

