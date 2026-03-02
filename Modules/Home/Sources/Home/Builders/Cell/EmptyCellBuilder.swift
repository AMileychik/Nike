//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import UIKit
import AppDomain

// MARK: - EmptyCellBuilder

/// Builder responsible for creating an "empty" placeholder cell.
///
/// Responsibilities:
/// - Returns a hidden, non-interactive cell when a section has no content.
/// - Used as a fallback in `HomeCellBuilderRegistry` when no other builder is registered.
final class EmptyCellBuilder: HomeCellBuilding {

    // MARK: - HomeCellBuilding

    /// Builds a hidden `UITableViewCell`.
    ///
    /// - Parameters:
    ///   - tableView: The table view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - section: The `HomeFeatureSection` (ignored in this builder).
    ///   - actionHandler: Optional handler for cell actions (ignored in this builder).
    /// - Returns: A hidden and non-interactive `UITableViewCell`.
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.isHidden = true
        cell.isUserInteractionEnabled = false
        return cell
    }
}

