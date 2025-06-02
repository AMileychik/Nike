//
//  ShopVC.swift
//  Nike
//
//  Created by Александр Милейчик on 10/30/24.
//

import UIKit

protocol ShopViewControllerProtocol: AnyObject {
    func updateView()
    func startLoading()
    func navigateToShopDetailSections(with product: Product)
    func navigateToShopListDetailSections(with product: Product)
}

final class ShopViewController: UIViewController {
    
    private let presenter: ShopPresenterProtocol
    private var tableView: ShopTableView
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    weak var shopCoordinator: ShopCoordinator?

    init(presenter: ShopPresenterProtocol) {
        self.presenter = presenter
        self.tableView = ShopTableView(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupView()
        setupConstraints()
        presenter.viewDidLoad()
        activityIndicator.startAnimating()
    }
    
    private func setupStyle() {
        title = "Shop"
        navigationController?.setupNavigationBar()
    }
}

//MARK: - Navigation
extension ShopViewController {
    
    func navigateToShopDetailSections(with product: Product) {
        guard let shopCoordinator = self.shopCoordinator else { return }
        shopCoordinator.navigateToShopDetailSections(with: product)
    }
    
    func navigateToShopListDetailSections(with product: Product) {
        guard let shopCoordinator = self.shopCoordinator else { return }
        shopCoordinator.navigateToShopListDetailSections(with: product)
    }
}

//MARK: - Scrollable
extension ShopViewController: Scrollable {
    func scrollToTop() {
        tableView.scrollToTop(animated: true)
    }
}

//MARK: - IShopController
extension ShopViewController: ShopViewControllerProtocol {
    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
}

// MARK: - Layout
extension ShopViewController  {
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.tintColor = .gray
        activityIndicator.color = .black
    }
    
    private func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

