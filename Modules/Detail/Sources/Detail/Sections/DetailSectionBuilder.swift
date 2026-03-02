//
//  DetailSectionBuilder.swift
//  Nike
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation
import AppDomain
//
//final class DetailSectionBuilder {
//    
//    static func createProductDetailSections(from selection: TopPickSelection) -> [DetailSection] {
//        
//        let model = selection.products
//        let category = selection.category
//       
//        guard let firstProduct = model.first else { return [] }
//        var sections: [DetailSection] = []
//        
//        // MARK: - SubCategories
//        if let subCategories = 
//            firstProduct.categories?.first?.subCategories,
//           !subCategories.isEmpty {
//            
//            sections.append(.subCategories(subCategories))
//        }
//        
//        // MARK: - Categories
//        let categories = model.filter { $0.categoryName == category }
//        if !categories.isEmpty {
//            sections.append(.categories(categories))
//        }
//        
//        // MARK: - Description
//        if !model.isEmpty {
//            sections.append(.description(model))
//        }
//        
//        // MARK: - Product Size
//        if let productSize = firstProduct.productSize,
//           let shoesSizeHeader = firstProduct.productSizeHeader,
//           !productSize.isEmpty {
//            sections.append(.productSize(productSize, header: shoesSizeHeader))
//        }
//        
//        // MARK: - Action Buttons
//        if let subCategories = firstProduct.categories?.first?.subCategories?.first,
//           let actionButtons = firstProduct.detailButtonsName {
//            sections.append(.actionButtons(actionButtons, subCategories: subCategories))
//        }
//        
//        // MARK: - Auto Scrolling PageControl
//        if let autoScrollingPageControl = firstProduct.promo, !autoScrollingPageControl.isEmpty {
//            sections.append(.autoScrollingPageControl(autoScrollingPageControl))
//        }
//        
//        // MARK: - Product Description
//        if let productDescription = firstProduct.productDescription, !productDescription.isEmpty {
//            sections.append(.productDescription(productDescription))
//        }
//        
//        // MARK: - Complete The Look
//        if let completeTheLook = firstProduct.completeTheLook,
//           let completeTheLookHeader = firstProduct.completeTheLookHeader,
//           !completeTheLook.isEmpty {
//            sections.append(.completeTheLook(completeTheLook, header: completeTheLookHeader))
//        }
//        
//        // MARK: - You Might Also Like
//        if let youMightAlsoLike = firstProduct.youMightAlsoLike,
//           let youMightAlsoLikeHeader = firstProduct.youMightAlsoLikeHeader,
//           !youMightAlsoLike.isEmpty {
//            sections.append(.youMightAlsoLike(youMightAlsoLike, header: youMightAlsoLikeHeader))
//        }
//        
//        // MARK: - Product Info
//        if let productInfo = firstProduct.productInfo, !productInfo.isEmpty {
//            sections.append(.productInfo(productInfo))
//        }
//        return sections
//    }
//    
//    // MARK: - Promo
//    static func createPromoDetailSections(
//        model: [Product] ) -> [DetailSection] {
//            var sections: [DetailSection] = []
//            if !model.isEmpty {
//                sections.append(.horizontalProductInfo(model))
//            }
//            return sections
//        }
//    
//    // MARK: - New From Nike Sections
//    static func createNewFromNikeDetailSections(
//        model: [NewFromNikeModel] ) -> [DetailSection] {
//            var sections: [DetailSection] = []
//            if !model.isEmpty {
//                sections.append(.productInfoCell(model))
//            }
//            if let completeTheLook = model.first?.completeTheLookModel, let completeTheLookHeader = model.first?.completeTheLookHeader, !model.isEmpty {
//                sections.append(.completeTheLook(completeTheLook, header: completeTheLookHeader))
//            }
//            return sections
//        }
//    
//    // MARK: - Vertical New From Nike Sections
//    static func createVerticalNewFromNikeDetailSections(model: [NewFromNikeModel]) -> [DetailSection] {
//        var sections: [DetailSection] = []
//        if !model.isEmpty {
//            sections.append(.verticalProductInfoCell(model))
//        }
//        return sections
//    }
//    
//    // MARK: - Stories For You Sections
//    static func createStoriesForYouDetailSections(
//        model: [StoriesForYou] ) -> [DetailSection] {
//            var sections: [DetailSection] = []
//            if !model.isEmpty {
//                sections.append(.storiesForYou(model))
//            }
//            return sections
//        }
//    
//    // MARK: - Shop Sections
//    static func createShopDetailSections(
//        model: [Product] ) -> [DetailSection] {
//            var sections: [DetailSection] = []
//            if !model.isEmpty {
//                sections.append(.horizontalProductInfo(model))
//            }
//            return sections
//        }
//    
//    // MARK: - Shop List Sections
//    static func createShopListDetailSections(
//        model: [Product] ) -> [DetailSection] {
//            var sections: [DetailSection] = []
//            if let simple = model.first?.productInfo, !simple.isEmpty {
//                sections.append(.productInfo(simple))
//            }
//            return sections
//        }
//}
//




// Implement providers

public final class DetailSectionBuilder {
    
    static func createProductDetailSections(from selection: TopPickSelection) -> [DetailSection] {
        let model = selection.products
        let category = selection.category
        guard let firstProduct = model.first else { return [] }
        var sections: [DetailSection] = []
        
        // MARK: - SubCategories
        if let subCategories = firstProduct.categories?.first?.subCategories, !subCategories.isEmpty {
            sections.append(.subCategories(subCategories))
        }
        
        // MARK: - Categories
        let categories = model.filter { $0.categoryName == category }
        if !categories.isEmpty {
            sections.append(.categories(categories))
        }
        
        // MARK: - Description
        if !model.isEmpty {
            sections.append(.description(model))
        }
        
        // MARK: - Product Size
        if let sizes = firstProduct.productSize, let header = firstProduct.productSizeHeader, !sizes.isEmpty {
            sections.append(.productSize(sizes, header: header))
        }
        
        // MARK: - Action Buttons
        if let subCategory = firstProduct.categories?.first?.subCategories?.first,
           let buttons = firstProduct.detailButtonsName {
            sections.append(.actionButtons(buttons, subCategories: subCategory))
        }
        
        // MARK: - Auto Scrolling PageControl
        if let promo = firstProduct.promo, !promo.isEmpty {
            sections.append(.autoScrollingPageControl(promo))
        }
        
        // MARK: - Product Description
        if let descriptions = firstProduct.productDescription, !descriptions.isEmpty {
            sections.append(.productDescription(descriptions))
        }
        
        // MARK: - Complete The Look
        if let look = firstProduct.completeTheLook, let header = firstProduct.completeTheLookHeader, !look.isEmpty {
            sections.append(.completeTheLook(look, header: header))
        }
        
        // MARK: - You Might Also Like
        if let alsoLike = firstProduct.youMightAlsoLike, let header = firstProduct.youMightAlsoLikeHeader, !alsoLike.isEmpty {
            sections.append(.youMightAlsoLike(alsoLike, header: header))
        }
        
        // MARK: - Product Info
        if let info = firstProduct.productInfo, !info.isEmpty {
            sections.append(.productInfo(info))
        }
        
        return sections
    }
    
    // MARK: - Promo
    static func createPromoDetailSections(model: [Product]) -> [DetailSection] {
        guard !model.isEmpty else { return [] }
        return [.horizontalProductInfo(model)]
    }
    
    // MARK: - New From Nike
    static func createNewFromNikeDetailSections(model: [NewFromNikeModel]) -> [DetailSection] {
        guard !model.isEmpty else { return [] }
        var sections: [DetailSection] = [.productInfoCell(model)]
        if let look = model.first?.completeTheLookModel, let header = model.first?.completeTheLookHeader, !look.isEmpty {
            sections.append(.completeTheLook(look, header: header))
        }
        return sections
    }
    
    // MARK: - Vertical New From Nike
    static func createVerticalNewFromNikeDetailSections(model: [NewFromNikeModel]) -> [DetailSection] {
        guard !model.isEmpty else { return [] }
        return [.verticalProductInfoCell(model)]
    }
    
    // MARK: - Stories For You
    static func createStoriesForYouDetailSections(model: [StoriesForYou]) -> [DetailSection] {
        guard !model.isEmpty else { return [] }
        return [.storiesForYou(model)]
    }
    
    // MARK: - Shop
    static func createShopDetailSections(model: [Product]) -> [DetailSection] {
        guard !model.isEmpty else { return [] }
        return [.horizontalProductInfo(model)]
    }
    
    // MARK: - Shop List
    static func createShopListDetailSections(model: [Product]) -> [DetailSection] {
        guard let first = model.first?.productInfo, !first.isEmpty else { return [] }
        return [.productInfo(first)]
    }
}

