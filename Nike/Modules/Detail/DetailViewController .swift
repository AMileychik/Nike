//
//  DetailVC.swift
//  Nike
//
//  Created by Александр Милейчик on 10/28/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let tableView: DetailTableView
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.tableView = DetailTableView(detailViewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupViews()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupStyle() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bindViewModel() {
        viewModel.stateChanged = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .initial:
                    break
                case .loading:
                    break
                case .loaded:
                    self?.tableView.updateSections(self?.viewModel.detailSections ?? [])
                case .error(let message):
                    print("Error: \(message)")
                }
            }
        }
    }
    
    func updateProductDetailSections(model: TopPickSelection) {
        title = model.products.first?.type
        viewModel.loadProductDetails(model: model)
    }
    
    func updatePromoDetailSections(model: [Product]) {
        title = model.first?.type
        viewModel.loadPromoDetails(model: model)
    }
    
    func updateNewFromNikeDetailSections(model: [NewFromNikeModel]) {
        title = model.first?.title
        viewModel.loadNewFromNikeDetails(model: model)
    }
    
    func updateVerticalNewFromNikeDetailSections(model: [NewFromNikeModel]) {
        title = model.first?.title
        viewModel.loadVerticalNewFromNikeDetails(model: model)
    }
    
    func updateStoriesForYouDetailSections(model: [StoriesForYou]) {
        title = model.first?.largeImageLabel1
        viewModel.loadStoriesForYouDetails(model: model)
    }
    
    func updasteShopDetailSections(model: [Product]) {
        viewModel.loadShopDetails(model: model)
    }
    
    func updateShopListDetailSections(model: [Product]) {
        viewModel.loadShopListDetails(model: model)
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
