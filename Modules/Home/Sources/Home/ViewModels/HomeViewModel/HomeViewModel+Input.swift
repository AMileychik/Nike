//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/10/25.
//

import UIKit

import Combine

import AppDomain
import AppInterface

// MARK: - HomeViewModel Actions & Loading

extension HomeViewModel {
    
    // MARK: - Load Products
    
    /// Called when the Home screen appears.
    /// Triggers loading products only if the current state is `.initial`.
    public func onAppear() {
        guard case .initial = state else { return }
        loadProducts()
    }
    
    /// Initiates loading of Home products from the network.
    /// Cancels any ongoing task, sets the state to `.loading`,
    /// and updates the view upon success or failure.
    public func loadProducts() {
        // Cancel any previous loading task
        loadProductsTask?.cancel()
        
        // Update state to loading
        setState(.loading)
        
        // Start a new asynchronous task
        loadProductsTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                // Execute the network request
                let response = try await self.useCase.execute()
                
                // Handle successful response
                self.handleSuccess(response)
                
            } catch {
                // Ignore cancelled tasks
                guard !Task.isCancelled else { return }
                
                // Handle errors
                self.handleError(error)
            }
        }
    }
    
    // MARK: - User Events
    
    /// Handles user interactions or other events from the Home screen.
    /// - Parameter action: The event to handle.
    public func sendEvent(_ action: HomeViewModelEvent) {
        switch action {
            
        case .homeTopPicksDidTap(let model):
            setEffect(.becauseYouLike(model))
            
        case .promoDidTap(let model):
            setEffect(.promo(model))
            
        case .newFromNikeDidTap(let model):
            setEffect(.newFromNike(model))
            
        case .storiesForYouDidTap(let model):
            setEffect(.stories(model))
            
        case .refreshData:
            loadProducts()
            
        case .barButtonDidTap, .headerButtonDidTap:
            setEffect(.comingSoon)
            
        case .exploreButtonDidTap(let model):
            setEffect(.explore(model))
        }
    }
}
