//
//  HomeTableViewDataSource.swift
//  Nike
//
//  Created by Александр Милейчик on 3/23/25.
//

import UIKit

import AppDomain
import DesignSystem
import AppCore

// MARK: - HomeTableViewAdapter

/// Acts as the `UITableViewDataSource` for the Home feature.
///
/// Responsibilities:
/// - Delegates cell creation to `HomeCellFactory`.
public final class HomeTableViewAdapter: NSObject, HomeTableViewAdapterProtocol {
    
    // MARK: - Dependencies
    
    private let viewModel: HomeViewModelProtocol
    private let cellFactory: HomeCellFactoryProtocol
    private let actionHandler: HomeCellActionHandlerProtocol
    
    // MARK: - Initialization

    public init(
        viewModel: HomeViewModelProtocol,
        cellFactory: HomeCellFactoryProtocol,
        actionHandler: HomeCellActionHandlerProtocol
    ) {
        self.viewModel = viewModel
        self.cellFactory = cellFactory
        self.actionHandler = actionHandler
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel.section(at: section) else {
            assertionFailure("Section at index \(section) does not exist")
            return 0
        }
        return section.numberOfRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel.section(at: indexPath.section) else {
            assertionFailure("Section at index \(indexPath.section) does not exist")
            return UITableViewCell(style: .default, reuseIdentifier: "Fallback")
        }
        
        let cell = cellFactory.makeCell(
            tableView: tableView,
            indexPath: indexPath,
            section: section,
            actionHandler: actionHandler
        )
        return cell
    }
}
