//
//  BagTableViewManager.swift
//  
//
//  Created by Александр Милейчик on 6/19/25.
//

import UIKit

public final class BagTableViewManager: NSObject {
    
    // MARK: - Private Properties
    
    private let viewModel: BagViewModelProtocol
    private var swipeProvider: BagSwipeActionProvider?
    private weak var tableView: UITableView?
    
    // MARK: - Init
    
    public init(viewModel: BagViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods
    
    public func configure(tableView: UITableView, adapter: UITableViewDataSource) {
        
        self.tableView = tableView
        self.swipeProvider = BagSwipeActionProvider(viewModel: viewModel, tableView: tableView)
        
        tableView.dataSource = adapter
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(BagCell.self)
        tableView.registerCell(TotalPriceCell.self)
    }
}

// MARK: - UITableViewDelegate

extension BagTableViewManager: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        swipeProvider?.swipeActions(for: indexPath)
    }
}

// MARK: - BagCellDelegate

extension BagTableViewManager: BagCellDelegate {
    
    public func didRequestEditQuantity(for model: BagProductUIModel) {
        viewModel.sendEvent(.quantityPickerDidTap(model))
    }
    
    public func didRequestDeleteItem(at indexPath: IndexPath, model: BagProductUIModel) {
        viewModel.deleteProduct(model)
        viewModel.updateSections()
        
        tableView?.beginUpdates()
        tableView?.deleteRows(at: [indexPath], with: .automatic)
        tableView?.endUpdates()
    }
}
