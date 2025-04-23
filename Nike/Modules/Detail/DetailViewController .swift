//
//  DetailVC.swift
//  Nike
//
//  Created by Александр Милейчик on 10/28/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let tableView = DetailTableView()
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupViews()
        setupConstraints()
    }
    
    private func setupStyle() {
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - Data Loading
extension DetailViewController {
    
    //MARK: - ProductDetailSections
    func updateProductDetailSections(model: [Product], categories: Categories, header: Header, category: String, subCategory: SubCategoryModel
    ) {
        title = model.first?.type
        
        tableView.updateSections(DetailSectionBuilder.createProductDetailSections(model: model, categories: categories, header: header, category: category, subCategory: subCategory))
    }
    
    //MARK: - PromoDetailSections
    func updatePromoDetailSections(model: [Product]) {
        title = model.first?.type
        tableView.updateSections(DetailSectionBuilder.createPromoDetailSections(model: model))
    }
    
    //MARK: - NewFromNikeDetailSections
    func updateNewFromNikeDetailSections(model: [NewFromNikeModel]){
        title = model.first?.title
        tableView.updateSections(DetailSectionBuilder.createNewFromNikeDetailSections(model: model))
    }
    
    //MARK: - NewFromNikeVerticalDetailSections
    func updateVerticalNewFromNikeDetailSections(model: [NewFromNikeModel]) {
        title = model.first?.title
        tableView.updateSections(DetailSectionBuilder.createVerticalNewFromNikeDetailSections(model: model))
    }
    
    //MARK: - StoriesForYouDetailSections
    func updateStoriesForYouDetailSections(model: [StoriesForYou]) {
        title = model.first?.largeImageLabel1
        tableView.updateSections(DetailSectionBuilder.createStoriesForYouDetailSections(model: model))
    }
    
    //MARK: - ShopDetailSections
    func updasteShopDetailSections(model: [Product]) {
        tableView.updateSections(DetailSectionBuilder.createShopDetailSections(model: model))
    }
    
    //MARK: - ShopListDetailSections
    func updateShopListDetailSections(model: [Product]) {
        tableView.updateSections(DetailSectionBuilder.createShopListDetailSections(model: model))
    }
}

// MARK: - Layout
extension DetailViewController {
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

