//
//  HomeTableView.swift
//  Nike
//
//  Created by Александр Милейчик on 10/29/24.
//

import UIKit

import AppCore

// MARK: - HomeTableViewContainer

/// A table container used by `HomeViewController`.
///
/// - `BaseTableViewContainer` — provides base table setup and configuration.
/// - `HomeTableViewContainerProtocol` — exposes required functionality to HomeViewController.
public final class HomeTableViewContainer: BaseTableViewContainer {
    
    // MARK: - Initialization
    
    /// Initializes the container with a controller.
    /// 
    /// - Parameter controller: Responsible for providing table data and handling events.
    public override init(controller: BaseTableControllerProtocol) {
        super.init(controller: controller)
    }
    
    /// Not supported from storyboard/XIB.
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public API

extension HomeTableViewContainer: HomeTableViewContainerProtocol {
    
    /// The pull-to-refresh control for the table.
    public var refreshControl: UIRefreshControl? {
        get { tableView.refreshControl }
        set { tableView.refreshControl = newValue }
    }
    
    /// Reloads the table content.
    public func reloadData() {
        tableView.reloadData()
    }

    /// Scrolls the table to the top.
    public func scrollToTop(animated: Bool = true) {
        tableView.setContentOffset(.zero, animated: animated)
    }
}
