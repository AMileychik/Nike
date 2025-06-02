//
//  ViewController.swift
//  Nike
//
//  Created by Александр Милейчик on 9/27/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let homeViewModel: HomeViewModel
    private var tableView: HomeTableView
    
    private var refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    weak var homeCoordinator: HomeCoordinator?
    
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
        setupRefreshControl()
        setupViews()
        setupActivityIndicator()
        setupConstraints()
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
        self.refreshControl.endRefreshing()
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

extension HomeViewController {
    
    private func bindViewModel() {
        homeViewModel.stateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.updateUI(for: state)
            }
        }
        
        homeViewModel.routeHandler = { [weak self] navigation in
            guard let self = self else { return }
            guard let homeCoordinator = self.homeCoordinator else { return }
            
            switch navigation {
                
            case .becauseYouLike(let model):
                homeCoordinator.showProductDetail(model: model)
                
            case .promo(let model):
                homeCoordinator.showPromoDetail(model: model)
                
            case .stories(let model):
                homeCoordinator.showStoriesForYouDetail(model: model)
                
            case .newFromNike(let model):
                homeCoordinator.showNewFromNikeDetail(model: model)
                
            case .explore(let model):
                homeCoordinator.showNewFromNikeVerticalDetail(model: model)
                
            case .comingSoon(let fromVC):
                homeCoordinator.showComingSoon(from: fromVC)
            }
        }
    }
    
    private func updateUI(for state: HomeViewModelState) {
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

