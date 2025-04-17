//
//  BagTableView.swift
//  LagomStore
//
//  Created by Александр Милейчик on 12/13/24.
//

import UIKit

enum BagSection {
    case products([SubCategoryModel])
    case totalPrice(Double)
}

final class BagTableView: UITableView {

    private var productsService: FavoritesServiceProtocol = FavoritesService()
    private var bagService = BagService()
    private var products: [SubCategoryModel] = []
    private var totalPrice: Double = 0.0
    weak var parentViewController: UIViewController?
    
    var bagSections: [BagSection] {
        get {
            return [
                .products(products),
                .totalPrice(totalPrice)
            ]
        }
        set {
            updateSections(with: newValue)
        }
    }

    private func updateSections(with sections: [BagSection]) {
        for section in sections {
            switch section {
            case .products(let data):
                products = data
            case .totalPrice(let data):
                totalPrice = data
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func commonInit() {
        allowsSelection = false
        separatorStyle = .none
        delegate = self
        dataSource = self
        registerCell(BagCell.self)
        registerCell(TotalPriceCell.self)
    }
    
    func updateTotalPrice(with price: Double) {
        totalPrice = price
        DispatchQueue.main.async {
            self.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    private func updateBagAndPrice(for model: SubCategoryModel) {
        let updatedData = bagService.delete(model)
        products = updatedData
        
        let newTotalPrice = bagService.calculateTotalPrice()
        updateTotalPrice(with: newTotalPrice)
    }
}

// MARK: - UITableViewDataSource
extension BagTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = bagSections[section]
       
        switch sectionData {
        case .products(let model):
            return model.count
        case .totalPrice:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return bagSections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionData = bagSections[indexPath.section]
        switch sectionData {
            
        case .products(let model):
            
            let cell = tableView.dequeueCell(indexPath) as BagCell
            cell.delegate = self
            cell.parentViewController = parentViewController
            let model = model[indexPath.row]
            cell.update(model)
            cell.configureCellSeparator(indexPath: indexPath, numberOfRowsInSection: tableView.numberOfRows(inSection: indexPath.section))
            return cell

        case .totalPrice:
            
            let cell = tableView.dequeueCell(indexPath) as TotalPriceCell
            cell.totalPrice = totalPrice
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension BagTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard indexPath.section == 0 else { return nil }

        let delete = createSwipeAction(title: "", style: .destructive) { [weak self] _, _, completionHandler in
            self?.deleteItemFromBag(at: indexPath, completionHandler: completionHandler)
        }
        delete.image = Image.cart

        let addToFavorite = createSwipeAction(title: "", style: .normal) { [weak self] _, _, completionHandler in
            self?.addItemToFavorites(at: indexPath, completionHandler: completionHandler)
        }
        addToFavorite.image = Image.heart
        
        return UISwipeActionsConfiguration(actions: [delete, addToFavorite])
    }
    
    private func createSwipeAction(title: String, style: UIContextualAction.Style, handler: @escaping (UIContextualAction, UIView, @escaping (Bool) -> Void) -> Void) -> UIContextualAction {
        let action = UIContextualAction(style: style, title: title, handler: handler)
        action.backgroundColor = UIColor.lightGray.adjustBrightness(by: 0.235)
        return action
    }
    
    private func deleteItemFromBag(at indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
        guard indexPath.row < products.count else {
            completionHandler(false)
            return
        }
        let model = products[indexPath.row]
        didRequestDeleteItem(at: indexPath, model: model)
        completionHandler(true)
    }
    
    func addItemToFavorites(at indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
        guard indexPath.row < products.count else { return }
        let selectedItem = products[indexPath.row]
        productsService.saveAndAdd([selectedItem])
        completionHandler(true)
    }
}

extension BagTableView: BagCellDelegate {

    func didUpdatePrice(totalPrices: Double) {
        updateTotalPrice(with: bagService.calculateTotalPrice())
    }

    func didRequestDeleteItem(at indexPath: IndexPath, model: SubCategoryModel) {
        updateBagAndPrice(for: model)
        deleteRows(at: [indexPath], with: .automatic)
        self.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

