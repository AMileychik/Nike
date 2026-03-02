//
//  File.swift
//
//
//  Created by Александр Милейчик on 11/4/25.
//

import DesignSystem
import AppInterface
import UIKit
import AppDomain

public final class DetailTableViewManager: NSObject, UITableViewDelegate {
    
    public let viewModel: DetailViewModelProtocol
    public weak var tableView: DetailTableView?
    
    public init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    public func configure(tableView: DetailTableView, adapter: UITableViewDataSource) {
        
        self.tableView = tableView
        
        tableView.dataSource = adapter
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.registerCell(DetailProductsContainer.self)
        tableView.registerCell(CategoriesContainer.self)
        tableView.registerCell(DescriptionCell.self)
        tableView.registerCell(SizeContainer.self)
        tableView.registerCell(DetailButtons.self)
        tableView.registerCell(PromoCarouselCell.self)
        tableView.registerCell(ProductDescriptionCell.self)
        tableView.registerCell(MediumSquareContainer.self)
        tableView.registerCell(CompleteTheLook.self)
        tableView.registerCell(ProductDescriptionCell.self)
        tableView.registerCell(HorizontalProductInfoCell.self)
        tableView.registerCell(VerticalProductInfoCell.self)
    }
}


// MARK: - CategoriesContainerDelegate

extension DetailTableViewManager: CategoriesContainerDelegate {
    public func didSelectSubCategory(with model: [SubCategoryModel], subCategory: String) {
        viewModel.detailSections[0] = .subCategories(model)
        tableView?.reloadData()
    }
    
    public func didSelectCategory(_ subCategory: SubCategoryModel) {
        viewModel.updateSelectedSubCategory(subCategory)
    }
}

// MARK: - CompleteTheLookProtocol

extension DetailTableViewManager: CompleteTheLookProtocol {
    public func toCommingSoonVC() {
        viewModel.sendEvent(.completeTheLookDidTap)
    }
}
