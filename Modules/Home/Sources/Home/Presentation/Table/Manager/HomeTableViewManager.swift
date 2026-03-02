//
//  File.swift
//
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

import DesignSystem
import AppDomain

// MARK: - HomeTableViewManager

/// Manages `UITableView` delegate responsibilities and cell registration for the Home feature.
///
/// Responsibilities include:
/// - Registering all necessary cells for the table.
/// - Handling cell lifecycle events (`willDisplay` / `didEndDisplaying`) for `LifecycleAwareCell`.
/// - Tracking visibility of cells that conform to `VisibilityTrackable`.
public final class HomeTableViewManager: NSObject, HomeTableViewManagerProtocol {
    
    // MARK: - Cell Registration
    
    /// Registers all required cells for the table view.
    public func registerCells(for tableView: UITableView) {
        tableView.registerCell(WelcomeCell.self)
        tableView.registerCell(CarouselContainer<AnyItemModel, Header>.self)
        tableView.registerCell(PromoCarouselCell.self)
        tableView.registerCell(NewFromNikeCell.self)
        tableView.registerCell(StoriesForYouCell<StoriesForYouProps, Header>.self)
        tableView.registerCell(ThankYouCell.self)
        tableView.registerCell(EmptyCell.self)
    }
}

// MARK: - UITableViewCell Lifecycle Handling

private extension HomeTableViewManager {
    
    /// Notifies lifecycle-aware cells of events.
    /// - Parameters:
    ///   - cell: The cell being displayed or removed.
    ///   - event: The lifecycle event (`willDisplay` or `didEndDisplaying`).
    func notifyLifecycleAwareCell(
        _ cell: UITableViewCell,
        event: CellLifecycleEvent
    ) {
        guard let cell = cell as? LifecycleAwareCell else { return }
        
        switch event {
        case .willDisplay:
            cell.willDisplay()
        case .didEndDisplaying:
            cell.didEndDisplaying()
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeTableViewManager: UITableViewDelegate {
    
    /// Tracks visibility of `VisibilityTrackable` cells when scrolling.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView else { return }
        
        tableView.visibleCells.forEach { cell in
            guard let trackable = cell as? VisibilityTrackable else { return }
            trackable.handleVisibility()
        }
    }
    
    /// Called when a cell is about to appear on screen.
    public func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        notifyLifecycleAwareCell(cell, event: .willDisplay)
    }
    
    /// Called when a cell is removed from the screen.
    public func tableView(
        _ tableView: UITableView,
        didEndDisplaying cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        notifyLifecycleAwareCell(cell, event: .didEndDisplaying)
    }
}
