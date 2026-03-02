//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import Foundation

import AppInterface
import DesignSystem
import AppDomain

//public final class HomeViewModelFactory: HomeViewModelFactoryProtocol, ViewModelFactoryProtocol {
//
//    public let container: DependencyContainerProtocol
//
//    public init(container: DependencyContainerProtocol) {
//        self.container = container
//    }
//
//    @MainActor
//    public func makeHomeViewModel(
//        sectionBuilder: HomeSectionBuildingProtocol,
//        errorMapper:HomeErrorMapping
//    ) -> HomeViewModelProtocol {
//
//        return HomeViewModel(
//            useCase: container.networkService,
//            sectionBuilder: sectionBuilder,
//            errorMapper: errorMapper
//        )
//    }
//}

public final class HomeViewModelFactory: HomeViewModelFactoryProtocol, ViewModelFactoryProtocol {
    
    // MARK: - Dependencies
    
    private let container: DependencyContainerProtocol
    
    // MARK: - Init
    
    public init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    // MARK: - Public
    
    /// Creates a HomeViewModel with the provided section builder and error mapper
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
    
    
    // MARK: - PromoCarouselViewModel
    public func makePromoCarouselViewModel(
        for pages: [PromoPageViewData]
    ) -> PromoCarouselViewModelProtocol {
        PromoCarouselViewModel(pages: pages)
    }
    
}
