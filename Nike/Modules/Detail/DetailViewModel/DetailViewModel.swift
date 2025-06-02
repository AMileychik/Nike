//
//  DetailViewModel.swift
//  Nike
//
//  Created by Александр Милейчик on 6/1/25.
//

import UIKit

enum DetailViewModelState {
    case initial
    case loading
    case loaded
    case error(String)
}

final class DetailViewModel {
    
    // MARK: - Properties
    var detailSections: [DetailSection] = []
    var stateChanged: ((DetailViewModelState) -> Void)?

    func loadProductDetails(model: TopPickSelection) {
        detailSections = DetailSectionBuilder.createProductDetailSections(from: model)
    }

    func loadPromoDetails(model: [Product]) {
        detailSections = DetailSectionBuilder.createPromoDetailSections(model: model)
    }

    func loadNewFromNikeDetails(model: [NewFromNikeModel]) {
        detailSections = DetailSectionBuilder.createNewFromNikeDetailSections(model: model)
    }

    func loadVerticalNewFromNikeDetails(model: [NewFromNikeModel]) {
        detailSections = DetailSectionBuilder.createVerticalNewFromNikeDetailSections(model: model)
    }

    func loadStoriesForYouDetails(model: [StoriesForYou]) {
        detailSections = DetailSectionBuilder.createStoriesForYouDetailSections(model: model)
    }

    func loadShopDetails(model: [Product]) {
        detailSections = DetailSectionBuilder.createShopDetailSections(model: model)
    }

    func loadShopListDetails(model: [Product]) {
        detailSections = DetailSectionBuilder.createShopListDetailSections(model: model)
    }
    
    func numberOfSections() -> Int {
        return detailSections.count
    }
    
    func section(at index: Int) -> DetailSection? {
        guard index >= 0 && index < detailSections.count else { return nil }
        return detailSections[index]
    }
}
