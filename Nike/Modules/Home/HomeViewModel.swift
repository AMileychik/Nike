//
//  HomeViewModel.swift
//  Nike
//
//  Created by Александр Милейчик on 1/27/25.
//

import UIKit

class HomeViewModel {
    
    enum Event {
        case homeTopPicksDidTap(model: [Product], categories: Categories?, header: Header?, category: String, subCategory: SubCategoryModel?)
        case promoDidTap(_ model: [Product])
        case newFromNikeDidTap(_ model: [NewFromNikeModel])
        case storiesForYouDidTap(_ model: [StoriesForYou])
        case refreshData
        case barButtonDidTap
        case headerButtonDidTap
        case exploreButtonDidTap(_ model: [NewFromNikeModel])
    }
    
    enum State {
        case initial
        case loading
        case loaded(HomeSectionsResponse)
        case error(String)
    }
    
    private let homeLoader: NetworkServiceProtocol
    
    private(set) var homeSections: [HomeSection] = []
    
    private(set) var state: State = .initial {
        didSet { stateChanged?(state) }
    }
    
    var stateChanged: ((State) -> Void)?
    var sectionsChanged: (([HomeSection]) -> Void)?
    var navigateFromBecauseYouLike: (([Product], Categories?, Header?, String, SubCategoryModel?) -> Void)?
    var navigateFromPromo: (([Product]) -> Void)?
    var navigateFromExploreButton: (([NewFromNikeModel]) -> Void)?
    var navigateFromNewFromNike: (([NewFromNikeModel]) -> Void)?
    var navigateFromStoriesForYou: (([StoriesForYou]) -> Void)?
    var navigateToCommingSoonVC: ((UIViewController) -> Void)?
    
    init(homeLoader: NetworkServiceProtocol) {
        self.homeLoader = homeLoader
    }
    
    //MARK: - Data Handling
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
    
    private func handleSuccess(_ products: HomeSectionsResponse) {
        self.state = .loaded(products)
        self.homeSections = HomeSectionBuilder.createHomeSections(from: products)
        self.sectionsChanged?(homeSections)
    }
    
    func numberOfSections() -> Int {
        return homeSections.count
    }
    
    func section(at index: Int) -> HomeSection? {
        guard index >= 0 && index < homeSections.count else { return nil }
        return homeSections[index]
    }
    
    //MARK: - Event Handling
    func sendEvent(_ action: Event, from viewController: UIViewController? = nil) {
        switch action {
            
        case .homeTopPicksDidTap(let model,
                                 let categories,
                                 let header,
                                 let category,
                                 let subcategory):
            
            navigateFromBecauseYouLike?(model, categories, header, category, subcategory)
            
        case .promoDidTap(let model):
            navigateFromPromo?(model)
            
        case .newFromNikeDidTap(let model):
            navigateFromNewFromNike?(model)
            
        case .storiesForYouDidTap(let model):
            navigateFromStoriesForYou?(model)
            
        case .refreshData:
            loadProducts()
            
        case .barButtonDidTap:
            if let viewController = viewController {
                navigateToCommingSoonVC?(viewController)
            }
            
        case .headerButtonDidTap:
            if let viewController = viewController {
                navigateToCommingSoonVC?(viewController)
            }
            
        case .exploreButtonDidTap(let model):
            navigateFromExploreButton?(model)
        }
    }
}

