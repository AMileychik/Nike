//
//  ViewController.swift
//  Nike
//
//  Created by Alexander Mileychik Милейчик on 9/27/25.
//

import UIKit

import AppCore

// MARK: - HomeViewController
///
/// The entry point to the Home feature.
///
/// Thin view controller and focused on:
/// - Handling the view lifecycle.
/// - Displaying UI state updates.
/// - Forwarding user interactions to responsible components:
///
/// - `ContentView` — handles table or collection display.
/// - `ViewModel` — provides state and effects.
/// - `Binder` — coordinates UI events and state updates.
/// - `Coordinator` — manages navigation.
///
/// ## Generic ContentView
/// - `UITableView` can be replaced with a custom `CollectionView` container
/// - A mock container can be used for testing
/// - VC is agnostic to `UITableView` (uses HomeTableViewContainerProtocol)
///
/// - `BaseViewController` handles the layout and lifecycle infrastructure.
final class HomeViewController<
    ContentView: UIView & HomeTableViewContainerProtocol
>: BaseViewController<ContentView> {
    
    // MARK: - UI Dependencies
    
    private let activityIndicator: UIActivityIndicatorView
    let refreshControl: UIRefreshControl
    
    // MARK: - UI Service
    
    private let alertPresenter: AlertPresenting

    // MARK: - Initialization
    
    init(
        contentView: ContentView,
        refreshControl: UIRefreshControl,
        activityIndicator: UIActivityIndicatorView,
        alertPresenter: AlertPresenting
    ) {
        self.refreshControl = refreshControl
        self.activityIndicator = activityIndicator
        self.alertPresenter = alertPresenter
        super.init(contentView: contentView)
    }
    
    /// Not supported from storyboard/XIB
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }
    
    // MARK: - Alert Handling
    
    private func showAlert(title: String, message: String) {
        alertPresenter.show(title: title, message: message)
    }
}

// MARK: Functionality for UI dependencies and presentation logic

extension HomeViewController {
    
    /// Attaches the injected refresh control to the content view.
    func configureRefreshControl() {
        contentView.refreshControl = refreshControl
    }
    
    /// Triggers a content reload
    func reloadContent() {
        contentView.reloadData()
    }
}

// MARK: - Scroll Handling

/// Allows Tab bar to control scrolling behavior.
extension HomeViewController: Scrollable {
    
    func scrollToTop() {
        contentView.scrollToTop(animated: true)
    }
}

// MARK: - View State Rendering

extension HomeViewController: HomeViewDisplayingProtocol {
    
    /// Shows the global loading indicator.
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    /// Hides the global loading indicator.
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    /// Ends pull-to-refresh animation.
    func stopRefreshing() {
        refreshControl.endRefreshing()
    }
    
    /// Displays an error alert.
    func showError(message: String) {
        alertPresenter.showError(message: message)
    }
}

// MARK: - Layout

private extension HomeViewController {
    
    /// Adds and centers the activity indicator in the view.
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


