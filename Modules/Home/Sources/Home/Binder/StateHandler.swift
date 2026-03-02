//
//  File.swift
//
//
//  Created by Александр Милейчик on 11/9/25.
//

import Combine

// MARK: - StateHandler

/// Observes state changes from the `HomeViewModelOutput`
/// and updates the UI via `HomeViewDisplayingProtocol`.
///
/// Responsibilities:
/// - Subscribes to the view model's state publisher.
/// - Keeps UI rendering and business logic separated.
public final class StateHandler: StateHandlerProtocol {
    
    // MARK: - Dependencies
    
    private let output: HomeViewModelOutput
    public weak var homeScreen: HomeViewDisplayingProtocol?
    
    /// Stores Combine subscriptions to manage lifecycle.
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    /// - Parameters:
    ///   - output: The view model output providing state updates.
    ///   - homeScreen: The UI component responsible for rendering state.
    public init(
        output: HomeViewModelOutput,
        homeScreen: HomeViewDisplayingProtocol
    ) {
        self.output = output
        self.homeScreen = homeScreen
    }
    
    // MARK: - Public API
    
    /// Starts observing state updates from the view model.
    public func bind() {
        output.statePublisher
            .sink { [weak self] state in
                self?.handleStateChange(state)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private Handlers
    
    /// Maps `HomeViewModelState` to UI updates.
    private func handleStateChange(_ state: HomeViewModelState) {
        switch state {
        case .initial:
            break
            
        case .loading:
            homeScreen?.showLoading()
            
        case .loaded:
            homeScreen?.hideLoading()
            homeScreen?.stopRefreshing()
            homeScreen?.reloadContent()
            
        case .error(let error):
            homeScreen?.hideLoading()
            homeScreen?.stopRefreshing()
            
            if error.hasMessage {
                homeScreen?.showError(message: error.message)
            }
        }
    }
}
