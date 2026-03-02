//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

// MARK: - ViewBinder

/// Binds user interactions from the UI to the `HomeViewModelInput`.
///
/// Responsibilities:
/// - Observes UI events (e.g., refresh control, search button).
/// - Forwards user actions to the view model.
/// - Triggers initial view lifecycle events.
public final class ViewBinder: ViewBinderProtocol {
    
    // MARK: - Dependencies
    
    /// The input interface to send user events to the view model.
    private let input: HomeViewModelInput
    
    /// The view displaying the Home screen, used to attach actions.
    private weak var homeViewController: HomeViewDisplayingProtocol?
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - input: The view model input for sending events.
    ///   - viewController: The UI that exposes user actions.
    public init(input: HomeViewModelInput, viewController: HomeViewDisplayingProtocol) {
        self.input = input
        self.homeViewController = viewController
    }
    
    // MARK: - Public API
    
    /// Starts observing user actions and triggers initial lifecycle events.
    public func bind() {
        bindUserActions()
        input.onAppear()
    }
}

// MARK: - User Interaction Binding

private extension ViewBinder {
    
    /// Attaches UI events to corresponding input actions.
    func bindUserActions() {
        guard let viewController = homeViewController else { return }

        // Pull-to-refresh action
        viewController.refreshControl.addTarget(self, action: #selector(onRefreshTriggered), for: .valueChanged)
        viewController.configureRefreshControl()
    }
    
    /// Handles pull-to-refresh.
    @objc func onRefreshTriggered() {
        input.loadProducts()
    }
    
    /// Handles search button tap.
    @objc public func onSearchButtonTapped() {
        input.sendEvent(.barButtonDidTap)
    }
}
