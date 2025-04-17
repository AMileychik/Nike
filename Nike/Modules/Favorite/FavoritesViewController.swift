//
//  FavoriteVC.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/13/24.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let favoritesService: FavoritesServiceProtocol
    private var tableView = FavoritesTableView()
    private var isEditingMode = false
    
    init(favoritesService: FavoritesServiceProtocol = FavoritesService()) {
        self.favoritesService = favoritesService
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoritesSections()
    }
    
    private func setupStyle() {
        title = "Favorites"
        navigationController?.setupNavigationBar()
        navigationController?.addMagnifyButton(target: self, action: #selector(onSearchButtonTapped), title: Text.Favorite.edit, buttonTintColor: .darkGray)
    }
}

//MARK: - Scrollable
extension FavoritesViewController: Scrollable {
    func scrollToTop() {
        tableView.scrollToTop(animated: true)
    }
}

// MARK: - Data Loading
extension FavoritesViewController {
    
    private func updateFavoritesSections() {
        let fetchedProducts = favoritesService.fetch()
        
        tableView.favoriteSections = FavoriteSectionBuilder.createFavoriteSections(
            from: fetchedProducts)
        
        tableView.reloadData()
    }
}

//MARK: - Action Handler
extension FavoritesViewController {
    
    @objc private func onSearchButtonTapped() {
        isEditingMode.toggle()
        tableView.isEditingFavorites = isEditingMode
        navigationItem.rightBarButtonItem?.title = isEditingMode ? Text.Favorite.done : Text.Favorite.edit
        updateFavoritesSections()
    }
}

//MARK: - FavoritesTableViewCellDelegate
extension FavoritesViewController: FavoritesTableViewCellDelegate {
    
    func presentComingSoonViewController() {
        let comingSoonViewController = ComingSoonViewController()
        comingSoonViewController.modalPresentationStyle = .fullScreen
        present(comingSoonViewController, animated: true)
    }
}

// MARK: - Layout
extension FavoritesViewController {
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}




