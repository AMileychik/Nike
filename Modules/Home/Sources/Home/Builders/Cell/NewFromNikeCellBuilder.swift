//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//


import UIKit
import AppDomain
import DesignSystem

// MARK: - NewFromNikeCellBuilder

/// Builder responsible for creating cells for the "New From Nike" section on the Home screen.
///
/// Responsibilities:
/// - Dequeues and configures `NewFromNikeCell` with view data.
/// - Attaches the `HomeCellActionHandlerProtocol` to handle user interactions.
final class NewFromNikeCellBuilder: HomeCellBuilding {

    // MARK: - HomeCellBuilding

    /// Builds a `NewFromNikeCell` for the specified section.
    ///
    /// - Parameters:
    ///   - tableView: The table view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - section: The `HomeFeatureSection` representing the "New From Nike" section.
    ///   - actionHandler: Optional handler for cell actions.
    /// - Returns: A fully configured `NewFromNikeCell`.
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        // Ensure the section is of the correct type
        guard case .newFromNike(let viewData) = section else {
            return UITableViewCell()
        }
        
        // Dequeue the cell
        let cell: NewFromNikeCell = tableView.dequeueCell(indexPath)
        
        // Update the cell with view data
        cell.update(viewData)
        
        // Attach action handler
        cell.onAction = { action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        return cell
    }
}
