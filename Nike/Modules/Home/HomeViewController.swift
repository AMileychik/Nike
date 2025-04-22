//
//  ViewController.swift
//  LagomStore
//
//  Created by Александр Милейчик on 9/27/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let homeViewModel: HomeViewModel
    private var tableView: HomeTableView
    private var refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        self.tableView = HomeTableView(homeViewModel: homeViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupViews()
        setupActivityIndicator()
        setupConstraints()
        setupRefreshControl()
        bindViewModel()
        homeViewModel.loadProducts()
    }
    
    private func setupStyle() {
        navigationController?.addMagnifyButton(target: self, action: #selector(onSearchButtonTapped))
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(onRefreshTriggered), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func stopRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Scrollable
extension HomeViewController: Scrollable {
    func scrollToTop() {
        tableView.scrollToTop(animated: true)
    }
}

//MARK: - Action Handler
extension HomeViewController {
    
    @objc private func onSearchButtonTapped() {
        homeViewModel.sendEvent(.barButtonDidTap, from: self)
    }
    
    @objc private func onRefreshTriggered() {
        homeViewModel.sendEvent(.refreshData)
    }
}
//MARK: - Navigation
extension HomeViewController {
   
    func toProductDetailSections(model: [Product],
                                categories: Categories,
                                header: Header,
                                category: String,
                                subCategory: SubCategoryModel) {
        
        let detailVC = dependencyContainer.screenFactory.createDetailScreen()
        detailVC.updateProductDetailSections(model: model, 
                        categories: categories,
                        header: header, category: category,
                        subCategory: subCategory)
        
        push(detailVC)
    }
    
    func toPromoDetailSections(model: [Product]) {
        let detailVC = dependencyContainer.screenFactory.createDetailScreen()
        detailVC.updatePromoDetailSections(model: model)
        push(detailVC)
    }
    
    func toNewFromNikeDetailSections(model: [NewFromNikeModel]) {
        let detailVC = dependencyContainer.screenFactory.createDetailScreen()
        detailVC.updateNewFromNikeDetailSections(model: model)
        push(detailVC)
    }
    
    func toNewFromNikeVerticalDetailsections(model: [NewFromNikeModel]) {
        let detailVC = dependencyContainer.screenFactory.createDetailScreen()
        detailVC.updateVerticalNewFromNikeDetailSections(model: model)
        push(detailVC)
    }
    
    func toStoriesForYouDetailSections(model: [StoriesForYou]) {
        let detailVC = dependencyContainer.screenFactory.createDetailScreen()
        detailVC.updateStoriesForYouDetailSections(model: model)
        push(detailVC)
    }
    
    func navigateToComingSoon(from viewController: UIViewController) {
        let comingSoonVC = dependencyContainer.screenFactory.createComingSoonScreen()
        comingSoonVC.modalPresentationStyle = .fullScreen
        viewController.present(comingSoonVC, animated: true)
    }
}

extension HomeViewController {
    
    private func bindViewModel() {
        
        homeViewModel.stateChanged = { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUI(for: state)
            }
        }
        
        homeViewModel.navigateFromBecauseYouLike = { [weak self] model, categories, header, category, subcategory in
            guard let self = self else { return }
            
            let safeCategories = categories
            let safeHeader = header
            
            guard let subcategory = subcategory else {
                print("subCategory is nil")
                return
            }

            self.toProductDetailSections(model: model, categories: safeCategories!, header: safeHeader!, category: category, subCategory: subcategory)
        }
    
        homeViewModel.navigateFromPromo = { [weak self] model in
            guard let self = self else { return }
            self.toPromoDetailSections(model: model)
        }
        
        homeViewModel.navigateFromStoriesForYou = { [weak self] model in
            guard let self = self else { return }
            self.toStoriesForYouDetailSections(model: model)
        }
        
        homeViewModel.navigateFromNewFromNike = { [weak self] model in
            guard let self = self else { return }
            self.toNewFromNikeDetailSections(model: model)
        }
    
        homeViewModel.navigateFromExploreButton = { [weak self] model in
            guard let self = self else { return }
            self.toNewFromNikeVerticalDetailsections(model: model)
        }
        
        homeViewModel.navigateToCommingSoonVC = { [weak self] viewController in
            guard let self = self else { return }
            self.navigateToComingSoon(from: viewController)
        }
    }
    
    private func updateUI(for state: HomeViewModel.State) {
        switch state {
        
        case .initial:
            break
            
        case .loading:
            self.activityIndicator.startAnimating()
            
        case .loaded:
            self.activityIndicator.stopAnimating()
            self.stopRefreshing()
            tableView.reloadData()
            
        case .error(let error):
            print(error)
        }
    }
}

//MARK: - Layout
private extension HomeViewController {
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.tintColor = .gray
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCell {
            videoCell.resetMuteButton()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCell {
            videoCell.resetMuteButton()
        }
    }
}
