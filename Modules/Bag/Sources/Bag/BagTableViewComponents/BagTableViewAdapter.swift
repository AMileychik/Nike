//
//  BagTableViewAdapter.swift
//  
//
//  Created by Александр Милейчик on 6/19/25.
//

import UIKit

public final class BagTableViewAdapter: NSObject, UITableViewDataSource {
    
    private let viewModel: BagViewModelProtocol
    public weak var delegate: BagCellDelegate?
    
    public init(viewModel: BagViewModelProtocol, delegate: BagCellDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = viewModel.section(at: section) else { return 0 }
        switch sectionData {
            
        case .products(let models):
            return models.count
            
        case .totalPrice:
            return 1
        }
    }
}

// MARK: - Public Methods

extension BagTableViewAdapter {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let sectionData = viewModel.section(at: indexPath.section) else { return UITableViewCell() }
        
        switch sectionData {
            
        case .products(let models):
            return configureBagCell(for: models[indexPath.row], at: indexPath, in: tableView)
            
        case .totalPrice(let value):
            return configureTotalPriceCell(with: value, at: indexPath, in: tableView)
        }
    }
}

// MARK: - Private Cell Builders

private extension BagTableViewAdapter {
    
    private func configureBagCell(for model: BagProductUIModel, at indexPath: IndexPath, in tableView: UITableView) -> BagCell {
        
        let cell = tableView.dequeueCell(indexPath) as BagCell
        let isLast = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        cell.configure(with: model, isLast: isLast)
        cell.delegate = delegate
        return cell
    }
    
    private func configureTotalPriceCell(with model: Double, at indexPath: IndexPath, in tableView: UITableView) -> TotalPriceCell {
        
        let cell = tableView.dequeueCell(indexPath) as TotalPriceCell
        cell.configure(with: model)
        return cell
    }
}

