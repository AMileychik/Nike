//
//  DetailTableView.swift
//  Nike
//
//  Created by Александр Милейчик on 10/28/24.
//

import UIKit

final class DetailTableView: UITableView {
    
    private let detailViewModel: DetailViewModel

    private lazy var dataSourceManager = DetailTableViewDataSource(tableView: self, bagService: BagService(), favoritesService: FavoritesService(), detailViewModel: detailViewModel)
    
    init(detailViewModel: DetailViewModel, frame: CGRect = .zero, style: UITableView.Style = .plain) {
        self.detailViewModel = detailViewModel
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
        detailViewModel.detailSections = sections
        reloadData()
    }
}


