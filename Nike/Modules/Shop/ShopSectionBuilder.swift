//
//  ShopSectionBuilder.swift
//  LagomStore
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

protocol SectionBuilderProtocol {
    func createShopSections(from products: ShopSectionsResponse,
                            for buttonDataType: ButtonDataType) -> [ShopSection]
}

final class ShopSectionBuilder: SectionBuilderProtocol {
    
    func createShopSections(from products: ShopSectionsResponse,
                            for buttonDataType: ButtonDataType) -> [ShopSection] {
        
        var sections: [ShopSection] = [
            .buttons(products.buttonsSection)
        ]
        
        switch buttonDataType {
        case .men:
            sections.append(contentsOf: [
                .newThisWeek(model: products.men.newThisWeekSection, header: products.men.titleHeaderModel),
                .news(products.men.shopListSection),
                .newAndFeatured(model: products.men.clothing, header: products.men.clothingHeader),
                .rafaelNadal(model: products.men.nikeZoomFly6, header: products.men.nikeZoomFly6Header),
                .newAndFeatured(model: products.men.jackets, header: products.men.jacketsHeader),
                .classicsSpotlightCell(model: products.men.shoesSection, header: products.men.shoesSectionHeader),
                .nearbyStore(model: products.men.nearbyStores, header: products.men.nearbyStoresHeader)
            ])
        case .women:
            sections.append(contentsOf: [
                .newThisWeek(model: products.women.newThisWeekSection, header: products.women.titleHeaderModel),
                .news(products.women.shopListSection),
                .newAndFeatured(model: products.women.trends, header: products.women.titleHeaderModel),
                .classicsSpotlightCell(model: products.women.jordanSneakersSection, header: products.women.classicsSpotlightHeader),
                .newAndFeatured(model: products.women.classicsSpotlight, header: products.women.titleHeaderModel),
                .nearbyStore(model: products.women.nearbyStores, header: products.women.nearbyStoresHeader)
            ])
        case .kids:
            sections.append(contentsOf: [
                .newThisWeek(model: products.kids.newThisWeekSection, header: products.kids.titleHeaderModel),
                .news(products.kids.shopListSection),
                .newAndFeatured(model: products.kids.pinkNike, header: products.kids.pinkNikeHeader),
                .newAndFeatured(model: products.kids.jordanKids, header: products.kids.jordanKidsHeaderModel),
                .classicsSpotlightCell(model: products.kids.nikeNews, header: products.kids.nikeNewsHeader)
            ])
        }
        return sections
    }
}
