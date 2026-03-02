//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//


import UIKit
import AppDomain
import DesignSystem

// MARK: - PromoCellBuilder

/// Builder responsible for creating cells for the "Promo" section on the Home screen.
///
/// Responsibilities:
/// - Dequeues and configures `PromoCarouselCell` with view data and view model.
/// - Attaches the `HomeCellActionHandlerProtocol` to handle user interactions.
/// - Manages auto-scrolling for the promo carousel.
final class PromoCellBuilder: HomeCellBuilding {

    // MARK: - HomeCellBuilding

    /// Builds a `PromoCarouselCell` for the specified section.
    ///
    /// - Parameters:
    ///   - tableView: The table view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - section: The `HomeFeatureSection` representing the "Promo" section.
    ///   - actionHandler: Optional handler for cell actions.
    /// - Returns: A fully configured `PromoCarouselCell`.
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        // Ensure the section is of the correct type
        guard case .promo(let section) = section else {
            return UITableViewCell()
        }
        
        // Dequeue the cell
        let cell: PromoCarouselCell = tableView.dequeueCell(indexPath)
        
        // Configure the cell with view data
        cell.configure(with: section.viewData, itemHeight: 150)
        
        // Attach action handler
        cell.onAction = { action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        // Handle auto-scroll start
        cell.onStartAutoScrollRequested = {
            section.viewModel.onPageChange = { index in
                DispatchQueue.main.async {
                    cell.scrollToPage(index)
                }
            }
            section.viewModel.startAutoScroll()
        }
        
        // Handle auto-scroll stop
        cell.onStopAutoScrollRequested = {
            section.viewModel.stopAutoScroll()
        }
        
        return cell
    }
}

