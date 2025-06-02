//
//  DetailSectionBuilder.swift
//  Nike
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

enum DetailSection {
    case subCategories([SubCategoryModel])
    case categories([Product])
    case description([Product])
    case productSize([ProductSize], header: Header)
    case actionButtons(DetailButtonsModel, subCategories: SubCategoryModel)
    case autoScrollingPageControl([Product])
    case productDescription([ProductDescription])
    case completeTheLook([CompleteTheLookModel], header: CompleteTheLookHeader)
    case productInfoCell([NewFromNikeModel])
    case storiesForYou([StoriesForYou])
    case youMightAlsoLike([YouMightAlsoLikeModel], header: YouMightAlsoLikeHeader)
    case horizontalProductInfo([Product])
    case shopVCListCellSectiont([ProductInfo])
    case productInfo([ProductInfo])
    case verticalProductInfoCell([NewFromNikeModel])
    case verticalWithProductModel([VerticalProductModel])
    case descriptionModel([Description])
}

final class DetailSectionBuilder {
    
    static func createProductDetailSections(from selection: TopPickSelection) -> [DetailSection] {
        
        let model = selection.products
        let category = selection.category
        guard let firstProduct = model.first else { return [] }
        var sections: [DetailSection] = []
        
        // SubCategories
        if let subCategories = firstProduct.categories?.first?.subCategories, !subCategories.isEmpty {
            sections.append(.subCategories(subCategories))
        }
        
        // Categories
        let categories = model.filter { $0.categoryName == category }
        if !categories.isEmpty {
            sections.append(.categories(categories))
        }
        
        // Description
        if !model.isEmpty {
            sections.append(.description(model))
        }
        
        // Product Size
        if let productSize = firstProduct.productSize,
           let shoesSizeHeader = firstProduct.productSizeHeader,
           !productSize.isEmpty {
            sections.append(.productSize(productSize, header: shoesSizeHeader))
        }
        
        // Action Buttons
        if let subCategories = firstProduct.categories?.first?.subCategories?.first,
           let actionButtons = firstProduct.detailButtonsName {
            sections.append(.actionButtons(actionButtons, subCategories: subCategories))
        }
        
        // Auto Scrolling PageControl
        if let autoScrollingPageControl = firstProduct.promo, !autoScrollingPageControl.isEmpty {
            sections.append(.autoScrollingPageControl(autoScrollingPageControl))
        }
        
        // Product Description
        if let productDescription = firstProduct.productDescription, !productDescription.isEmpty {
            sections.append(.productDescription(productDescription))
        }
        
        // Complete The Look
        if let completeTheLook = firstProduct.completeTheLook,
           let completeTheLookHeader = firstProduct.completeTheLookHeader,
           !completeTheLook.isEmpty {
            sections.append(.completeTheLook(completeTheLook, header: completeTheLookHeader))
        }
        
        // You Might Also Like
        if let youMightAlsoLike = firstProduct.youMightAlsoLike,
           let youMightAlsoLikeHeader = firstProduct.youMightAlsoLikeHeader,
           !youMightAlsoLike.isEmpty {
            sections.append(.youMightAlsoLike(youMightAlsoLike, header: youMightAlsoLikeHeader))
        }
        
        // Product Info
        if let productInfo = firstProduct.productInfo, !productInfo.isEmpty {
            sections.append(.productInfo(productInfo))
        }
        
        return sections
    }
    
    //MARK: - Promo
    static func createPromoDetailSections(
        model: [Product] ) -> [DetailSection] {
            
            var sections: [DetailSection] = []
            
            if !model.isEmpty {
                sections.append(.horizontalProductInfo(model))
            }
            
            return sections
        }
    
    //MARK: - New From Nike Sections
    static func createNewFromNikeDetailSections(
        model: [NewFromNikeModel] ) -> [DetailSection] {
            
            var sections: [DetailSection] = []
            
            if !model.isEmpty {
                sections.append(.productInfoCell(model))
            }
            
            if let completeTheLook = model.first?.completeTheLookModel, let completeTheLookHeader = model.first?.completeTheLookHeader, !model.isEmpty {
                sections.append(.completeTheLook(completeTheLook, header: completeTheLookHeader))
            }
            
            return sections
        }
    
    //MARK: - Vertical New From Nike Sections
    static func createVerticalNewFromNikeDetailSections(
        model: [NewFromNikeModel] ) -> [DetailSection] {
            
            var sections: [DetailSection] = []
            
            if !model.isEmpty {
                sections.append(.verticalProductInfoCell(model))
            }
            
            return sections
        }
    
    //MARK: - Stories For You Sections
    static func createStoriesForYouDetailSections(
        model: [StoriesForYou] ) -> [DetailSection] {
            
            var sections: [DetailSection] = []
            
            if !model.isEmpty {
                sections.append(.storiesForYou(model))
            }
            
            return sections
        }
    
    //MARK: - Shop Sections
    static func createShopDetailSections(
        model: [Product] ) -> [DetailSection] {
            
            var sections: [DetailSection] = []
            
            if !model.isEmpty {
                sections.append(.horizontalProductInfo(model))
            }
            
            return sections
        }
    
    //MARK: - Shop List Sections
    static func createShopListDetailSections(
        model: [Product] ) -> [DetailSection] {
            
            var sections: [DetailSection] = []
            
            if let simple = model.first?.productInfo, !simple.isEmpty {
                sections.append(.productInfo(simple))
            }
            
            return sections
        }
}
