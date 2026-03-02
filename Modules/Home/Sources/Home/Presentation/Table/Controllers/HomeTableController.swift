//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/21/25.
//

import UIKit

import AppCore

// MARK: - HomeTableController

/// The controller responsible for providing data, delegate, and configuration
/// for `HomeTableViewContainer`.
final class HomeTableController: BaseTableControllerProtocol {

    // MARK: - Dependencies

    /// Provides table view data.
    let adapter: HomeTableViewAdapter

    /// Manages table view delegate events and cell registration.
    let manager: HomeTableViewManager

    // MARK: - Initialization
    
    init(
        adapter: HomeTableViewAdapter,
        manager: HomeTableViewManager
    ) {
        self.adapter = adapter
        self.manager = manager
    }

    // MARK: - Protocol Properties

    /// The data source for the table view.
    var dataSource: UITableViewDataSource {
        adapter
    }

    /// The delegate for the table view.
    var delegate: UITableViewDelegate {
        manager
    }

    // MARK: - Table Configuration

    /// Registers all necessary cells in the table view.
    func registerCells(in tableView: UITableView) {
        manager.registerCells(for: tableView)
    }

    /// Configures the table view appearance and behavior.
    func configure(tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
}
