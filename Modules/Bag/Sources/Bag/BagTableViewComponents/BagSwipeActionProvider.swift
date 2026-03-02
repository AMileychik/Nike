//
//  BagSwipeActionProvider.swift
//  
//
//  Created by Александр Милейчик on 6/19/25.
//

import UIKit

public final class BagSwipeActionProvider {
    
    // MARK: - Private Properties
    
    private let viewModel: BagViewModelProtocol?
    private weak var tableView: UITableView?
    
    // MARK: - Init
    
    public init(viewModel: BagViewModelProtocol?, tableView: UITableView?) {
        self.viewModel = viewModel
        self.tableView = tableView
    }
    
    // MARK: - Public Methods
    
    public func swipeActions(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let section = viewModel?.section(at: indexPath.section),
              case .products = section else { return nil }
        
        let delete = makeAction(style: .destructive, image: UIImage(systemName: "trash")) { [weak self] _, _, completion in
            self?.deleteItem(at: indexPath, completion: completion)
        }
        
        let favorite = makeAction(style: .normal, image: UIImage(systemName: "heart")) { [weak self] _, _, completion in
            self?.addToFavorites(at: indexPath, completion: completion)
        }
        
        return UISwipeActionsConfiguration(actions: [delete, favorite])
    }
    
    // MARK: - Private Methods
    
    private func makeAction(style: UIContextualAction.Style, image: UIImage?, handler: @escaping UIContextualAction.Handler) -> UIContextualAction {
        let action = UIContextualAction(style: style, title: nil, handler: handler)
        action.image = image
        action.backgroundColor = UIColor.lightGray.withAlphaComponent(0.85)
        return action
    }
    
    private func deleteItem(at indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        guard let section = viewModel?.section(at: indexPath.section),
              case let .products(models) = section,
              indexPath.row < models.count else {
            completion(false)
            return
        }
        
        let model = models[indexPath.row]
        viewModel?.deleteProduct(model)
        viewModel?.updateSections()
        
        tableView?.beginUpdates()
        tableView?.deleteRows(at: [indexPath], with: .automatic)
        tableView?.endUpdates()
        
        completion(true)
    }
    
    private func addToFavorites(at indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        guard let section = viewModel?.section(at: indexPath.section),
              case let .products(models) = section,
              indexPath.row < models.count else {
            completion(false)
            return
        }
        
        let product = models[indexPath.row]
        viewModel?.saveAndAddProduct(product)
        completion(true)
    }
}
