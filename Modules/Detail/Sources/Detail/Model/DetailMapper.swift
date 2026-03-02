//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/4/25.
//

import AppDomain

public enum DetailMapper {
    public static func map(_ data: DetailData) -> DetailUIModel {
        let title = data.title
        let sections: [DetailSection]
        
        switch data {
        case .topPick(let model):
            sections = DetailSectionBuilder.createProductDetailSections(from: model)
        case .promo(let products): 
            sections = DetailSectionBuilder.createPromoDetailSections(model: products)
        case .newFromNike(let items):
            sections = DetailSectionBuilder.createNewFromNikeDetailSections(model: items)
        case .verticalNew(let items):
            sections = DetailSectionBuilder.createVerticalNewFromNikeDetailSections(model: items)
        case .stories(let items):
            sections = DetailSectionBuilder.createStoriesForYouDetailSections(model: items)
        case .shop(let items):
            sections = DetailSectionBuilder.createShopDetailSections(model: items)
        case .shopList(let items):
            sections = DetailSectionBuilder.createShopListDetailSections(model: items)
        }
        
        return DetailUIModel(title: title, sections: sections)
    }
}
