//
//  DetailTableView.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/28/24.
//

import UIKit

final class DetailTableView: UITableView {
    
    private lazy var dataSourceManager = DetailTableViewDataSource(
            tableView: self,
            bagService: BagService(),
            favoritesService: FavoritesService()
            )
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        allowsSelection = false
        dataSource = dataSourceManager
    }
    
    private func registerCells() {
        registerCell(DetailProductsContainer.self)
        registerCell(CategoriesContainer.self)
        registerCell(DescriptionCell.self)
        registerCell(SizeContainer.self)
        registerCell(DetailButtons.self)
        registerCell(PromoCarouselCell.self)
        registerCell(ProductDescriptionCell.self)
        registerCell(MediumSquareContainer.self)
        registerCell(CompleteTheLook.self)
        registerCell(ProductDescriptionCell.self)
        registerCell(HorizontalProductInfoCell.self)
        registerCell(VerticalProductInfoCell.self)
    }
    
    func updateSections(_ sections: [DetailSection]) {
        dataSourceManager.detailSections = sections
        reloadData()
    }
}


