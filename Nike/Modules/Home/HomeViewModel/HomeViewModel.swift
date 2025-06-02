//
//  HomeViewModel.swift
//  Nike
//
//  Created by Александр Милейчик on 1/27/25.
//

import UIKit

class HomeViewModel {
    
    // MARK: - Properties
    private let homeLoader: NetworkServiceProtocol
    private var homeSections: [HomeSection] = []
    
    private(set) var state: HomeViewModelState = .initial {
        didSet { stateChanged?(state) }
    }
    
    var stateChanged: ((HomeViewModelState) -> Void)?
    var sectionsChanged: (([HomeSection]) -> Void)?
    var routeHandler: ((HomeRoute) -> Void)?
    
    // MARK: - Init
    init(homeLoader: NetworkServiceProtocol) {
        self.homeLoader = homeLoader
    }
    
    // MARK: - Public Methods
    func loadProducts() {
        state = .loading
        
        homeLoader.loadHomeData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                handleSuccess(products)
            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func numberOfSections() -> Int {
        return homeSections.count
    }
    
    func section(at index: Int) -> HomeSection? {
        guard index >= 0 && index < homeSections.count else { return nil }
        return homeSections[index]
    }
    
// MARK: - Event Handling
    func sendEvent(_ action: HomeViewModelEvent, from viewController: UIViewController? = nil) {
        switch action {
            
        case .homeTopPicksDidTap(let model):
            routeHandler?(.becauseYouLike(model))
            
        case .promoDidTap(let model):
            routeHandler?(.promo(model))
            
        case .newFromNikeDidTap(let model):
            routeHandler?(.newFromNike(model))
            
        case .storiesForYouDidTap(let model):
            routeHandler?(.stories(model))
            
        case .refreshData:
            loadProducts()
            
        case .barButtonDidTap, .headerButtonDidTap:
            if let viewController = viewController {
                routeHandler?(.comingSoon(from: viewController))
            }
            
        case .exploreButtonDidTap(let model):
            routeHandler?(.explore(model))
        }
    }
    
    // MARK: - Private Methods
    private func handleSuccess(_ products: HomeSectionsResponse) {
        self.state = .loaded(products)
        self.homeSections = HomeSectionBuilder.createHomeSections(from: products)
        self.sectionsChanged?(homeSections)
    }
}


