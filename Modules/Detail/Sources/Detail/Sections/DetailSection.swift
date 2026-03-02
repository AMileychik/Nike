//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import AppDomain

public enum DetailSection {
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
