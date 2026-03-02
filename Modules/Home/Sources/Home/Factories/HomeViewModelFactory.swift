//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import AppInterface
import DesignSystem
import AppDomain

// MARK: - HomeViewModelFactory
///
/// Central point for creating all ViewModels for the Home feature.
/// Ensures consistent dependency injection and separation of concerns.
/// Improves testability by providing ready-to-use ViewModels with required dependencies.

public final class HomeViewModelFactory: HomeViewModelFactoryProtocol, ViewModelFactoryProtocol {
    
    // MARK: - Dependencies
    
    /// Container that provides access to shared services, like networking or data stores
    private let container: DependencyContainerProtocol
    
    // MARK: - Initialization
    
    public init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    // MARK: - Public Factory Methods
    
    /// Creates a HomeViewModel
    /// - Parameters:
    ///   - sectionBuilder: Responsible for building sections of the Home screen
    ///   - errorMapper: Maps domain errors to UI-friendly messages
    /// - Returns: A fully configured HomeViewModel
    @MainActor
    public func makeHomeViewModel(
        sectionBuilder: HomeSectionBuildingProtocol,
        errorMapper: HomeErrorMapping
    ) -> HomeViewModelProtocol {
        HomeViewModel(
            useCase: container.networkService,
            sectionBuilder: sectionBuilder,
            errorMapper: errorMapper
        )
    }
    
    /// Creates a PromoCarouselViewModel
    /// - Parameter pages: Data for carousel pages
    /// - Returns: A configured PromoCarouselViewModel
    public func makePromoCarouselViewModel(
        for pages: [PromoPageViewData]
    ) -> PromoCarouselViewModelProtocol {
        PromoCarouselViewModel(pages: pages)
    }
}
