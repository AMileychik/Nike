//
//  ShopPresenter.swift
//
//
//  Created by Александр Милейчик on 6/23/25.
//


//import Foundation
//import AppInterface
//import AppDomain
//import ShopUI
//
//public final class ShopPresenter: ShopPresenterProtocol {
//    
//    private let shopLoader: NetworkServiceProtocol
//    private var selectedButtonIndex: Int = 0
//    private(set) var shopDataModels: [ShopSection] = []
//    private let sectionBuilder: SectionBuilderProtocol = ShopSectionBuilder()
//    public weak var view: ShopViewControllerProtocol?
//    
//    public var indicesForRecentlyViewed: [ButtonDataType: Int] = [
//        .men: 4,
//        .women: 4,
//        .kids: 1
//    ]
//    
//    public var recentlyViewedRemovedFor: [ButtonDataType: Bool] = [
//        .men: false,
//        .women: false,
//        .kids: false
//    ]
//    
//    public init(shopLoader: NetworkServiceProtocol) {
//        self.shopLoader = shopLoader
//    }
//    
//    public func selectedButtonType() -> ButtonDataType {
//        switch selectedButtonIndex {
//        case 0: return .men
//        case 1: return .women
//        case 2: return .kids
//        default: fatalError("Invalid button index")
//        }
//    }
//
//     func viewDidLoad() {
//         loadProducts(for: .men)
//     }
//    
//     func didSelectProduct(data: DetailData) {
//         view?.navigateToDetailVC(data: data)
//     }
//    
//     func handleButtonTap(_ index: Int) {
//         guard index != selectedButtonIndex else { return }
//         selectedButtonIndex = index
//         view?.startLoading()
//         loadProducts(for: selectedButtonType())
//     }
//    
//     func loadProducts(for buttonDataType: ButtonDataType) {
//         shopLoader.loadShopData { [weak self] result in
//             guard let self = self else { return }
//             switch result {
//             case .success(let products):
//                 self.updateSections(from: products, for: buttonDataType)
//                 self.addRecentlyViewedSection(with: products, for: buttonDataType)
//                 self.view?.updateView()
//             case .failure(let error):
//                 print(error)
//             }
//         }
//     }
//
//    private func updateSections(from products: ShopSectionsResponse, for buttonDataType: ButtonDataType) {
//        shopDataModels = sectionBuilder.createShopSections(from: products, for: buttonDataType)
//    }
//    
//    public func addRecentlyViewedSection(with products: ShopSectionsResponse, for buttonType: ButtonDataType) {
//        guard recentlyViewedRemovedFor[buttonType] == false else { return }
//        guard buttonType != .kids else { return }
//        guard !shopDataModels.contains(where: {
//            if case .recentlyViewed = $0 { return true }
//            return false
//        }) else { return }
//        
//        let addedSection: ShopSection
//        switch buttonType {
//        case .men:
//            addedSection = .rafaelNadal(
//                model: products.men.rafaelNadal,
//                header: products.men.rafaelNadalHeader
//            )
//        case .women:
//            addedSection = .recentlyViewed(
//                model: products.women.recentlyViewedSection,
//                header: products.women.recentlyViewedHeader
//            )
//        case .kids:
//            fatalError("Error")
//        }
//        
//        if let index = indicesForRecentlyViewed[buttonType] {
//            let validIndex = max(0, min(index, shopDataModels.count))
//            shopDataModels.insert(addedSection, at: validIndex)
//        }
//    }
//    
//     func removeRecentlyViewed(for buttonType: ButtonDataType) {
//         guard recentlyViewedRemovedFor[buttonType] == false else { return }
//         if let index = shopDataModels.firstIndex(where: {
//             if case .recentlyViewed = $0 { return true }
//             return false })
//         {
//             shopDataModels.remove(at: index)
//             recentlyViewedRemovedFor[buttonType] = true
//             view?.updateView()
//         }
//     }
//    
//    public func numberOfSections() -> Int {
//        return shopDataModels.count
//    }
//    
//    public func sections(at index: Int) -> ShopSection? {
//        guard index >= 0 && index < shopDataModels.count else { return nil }
//        return shopDataModels[index]
//    }
//}








//import Foundation
//import AppInterface
//import AppDomain
////import ShopUI
//import ShopDomain
//
//public final class ShopPresenter: ShopPresenterProtocol {
//    
//    private let shopLoader: NetworkServiceProtocol
//    private var selectedButtonIndex: Int = 0
//    private(set) var shopDataModels: [ShopSection] = []
//    private let sectionBuilder: SectionBuilderProtocol = ShopSectionBuilder()
//    public weak var view: ShopViewControllerProtocol?
//    
//    public var indicesForRecentlyViewed: [ButtonDataType: Int] = [
//        .men: 4,
//        .women: 4,
//        .kids: 1
//    ]
//    
//    public var recentlyViewedRemovedFor: [ButtonDataType: Bool] = [
//        .men: false,
//        .women: false,
//        .kids: false
//    ]
//    
//    public init(shopLoader: NetworkServiceProtocol) {
//        self.shopLoader = shopLoader
//    }
//    
//    public func selectedButtonType() -> ButtonDataType {
//        switch selectedButtonIndex {
//        case 0: return .men
//        case 1: return .women
//        case 2: return .kids
//        default: fatalError("Invalid button index")
//        }
//    }
//
//    public func viewDidLoad() {
//         loadProducts(for: .men)
//     }
//    
////     func didSelectProduct(data: DetailData) {
////         view?.navigateToDetailVC(data: data)
////     }
//    
//    public func handleButtonTap(_ index: Int) {
//         guard index != selectedButtonIndex else { return }
//         selectedButtonIndex = index
//         view?.startLoading()
//         loadProducts(for: selectedButtonType())
//     }
//    
//     func loadProducts(for buttonDataType: ButtonDataType) {
//         shopLoader.loadShopData { [weak self] result in
//             guard let self = self else { return }
//             switch result {
//             case .success(let products):
//                 self.updateSections(from: products, for: buttonDataType)
//                 self.addRecentlyViewedSection(with: products, for: buttonDataType)
//                 self.view?.updateView()
//             case .failure(let error):
//                 print(error)
//             }
//         }
//     }
//
//    private func updateSections(from products: ShopSectionsResponse, for buttonDataType: ButtonDataType) {
//        shopDataModels = sectionBuilder.createShopSections(from: products, for: buttonDataType)
//    }
//    
//    public func addRecentlyViewedSection(with products: ShopSectionsResponse, for buttonType: ButtonDataType) {
//        guard recentlyViewedRemovedFor[buttonType] == false else { return }
//        guard buttonType != .kids else { return }
//        guard !shopDataModels.contains(where: {
//            if case .recentlyViewed = $0 { return true }
//            return false
//        }) else { return }
//        
//        let addedSection: ShopSection
//        switch buttonType {
//        case .men:
//            addedSection = .rafaelNadal(
//                model: products.men.rafaelNadal,
//                header: products.men.rafaelNadalHeader
//            )
//        case .women:
//            addedSection = .recentlyViewed(
//                model: products.women.recentlyViewedSection,
//                header: products.women.recentlyViewedHeader
//            )
//        case .kids:
//            fatalError("Error")
//        }
//        
//        if let index = indicesForRecentlyViewed[buttonType] {
//            let validIndex = max(0, min(index, shopDataModels.count))
//            shopDataModels.insert(addedSection, at: validIndex)
//        }
//    }
//    
//    public func removeRecentlyViewed(for buttonType: ButtonDataType) {
//         guard recentlyViewedRemovedFor[buttonType] == false else { return }
//         if let index = shopDataModels.firstIndex(where: {
//             if case .recentlyViewed = $0 { return true }
//             return false })
//         {
//             shopDataModels.remove(at: index)
//             recentlyViewedRemovedFor[buttonType] = true
//             view?.updateView()
//         }
//     }
//    
//    public func numberOfSections() -> Int {
//        return shopDataModels.count
//    }
//    
//    public func sections(at index: Int) -> ShopSection? {
//        guard index >= 0 && index < shopDataModels.count else { return nil }
//        return shopDataModels[index]
//    }
//}
