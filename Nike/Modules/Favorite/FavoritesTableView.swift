//
//  FavoriteTableView.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/13/24.
//

import UIKit

enum FavoriteSection {
    case favorites(model: [SubCategoryModel])
}

final class FavoritesTableView: UITableView {
    
    var favoriteSections: [FavoriteSection] = []
    public var isEditingFavorites: Bool = false

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        dataSource = self
        allowsSelection = false
        separatorStyle = .none
        registerCell(FavoritesTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource
extension FavoritesTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return favoriteSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = favoriteSections[indexPath.section]
        switch sections {
            
        case .favorites(let model):
            let cell = tableView.dequeueCell(indexPath) as FavoritesTableViewCell
           
            cell.update(model, isEditing: isEditingFavorites)
            
            if let viewController = self.findParentViewController() as? FavoritesViewController {
                cell.delegate = viewController
            }
            return cell
        }
    }
}










