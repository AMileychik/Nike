//
//  HomeViewModel.swift
//  Nike
//
//  Created by Александр Милейчик on 1/27/25.
//

import Combine

import AppDomain
import AppInterface

// MARK: - HomeViewModel

/// The view model responsible for managing Home screen data, state, and effects.
///
/// Responsibilities include:
/// - Managing the view state (`initial`, `loading`, `loaded`, `error`).
/// - Sending one-time effects (e.g., navigation events) to the coordinator.
/// - Interacting with the network layer and mapping errors.
/// - Providing sections data for the Home table view.
@MainActor
public final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Published Properties
    
    /// The list of sections displayed on the Home screen.
    @Published private(set) var homeSections: [HomeSectionModel] = []
    
    /// The current view state.
    @Published private(set) var state: HomeViewModelState = .initial
    
    /// One-time effects to trigger actions like navigation.
    private let effectSubject = PassthroughSubject<HomeEffect, Never>()

    // MARK: - Combine Publishers
    
    public var statePublisher: AnyPublisher<HomeViewModelState, Never> {
        $state.eraseToAnyPublisher()
    }
    
    public var effectPublisher: AnyPublisher<HomeEffect, Never> {
        effectSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Dependencies
    
    public let useCase: NetworkServiceUseCaseProtocol
    public let sectionBuilder: HomeSectionBuildingProtocol
    private let errorMapper: HomeErrorMapping
    
    /// Currently running task for loading products.
    public var loadProductsTask: Task<Void, Never>? = nil
    
    // MARK: - Initialization
    
    public init(
        useCase: NetworkServiceUseCaseProtocol,
        sectionBuilder: HomeSectionBuildingProtocol,
        errorMapper: HomeErrorMapping
    ) {
        self.useCase = useCase
        self.sectionBuilder = sectionBuilder
        self.errorMapper = errorMapper
    }
    
    // MARK: - Private State Mutation Helpers
    
    /// Updates the current view state.
    func setState(_ newState: HomeViewModelState) {
        state = newState
    }
    
    /// Sends a one-time effect to the coordinator.
    func sendEffect(_ effect: HomeEffect) {
        effectSubject.send(effect)
    }
    
    /// Handles a successful products response.
    func handleSuccess(_ products: HomeSectionsResponse) {
        let sections = sectionBuilder.buildSections(from: products)
        homeSections = sections
        setState(.loaded)
    }
    
    /// Handles an error response.
    func handleError(_ error: Error) {
        state = .error(errorMapper.map(error))
    }
}
