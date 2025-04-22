//
//  HomeModel.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/8/24.
//

import UIKit

//MARK: - Home
struct HomeSectionsResponse: Codable {
   
    let topPicksHeader: Header
    let topPicks: [Product]
  
    let promo: [Product]
    
    let newFromNikeHeader: Header
    let newFromNike: [NewFromNikeModel]
    
    let nikeTrainingHeader: Header
    let nikeTraining: [Product]
    
    let storiesForYou: [StoriesForYou]
   
    let nikeSwiftAndStrideHeader: Header
    let nikeSwiftAndStride: [Product]
    
    let thankYou: [Product]
}

struct NewFromNikeModel: Codable {
    let videoURL: String?
    let image: String?
    let logoTitle: String?
    let detailImage: String?
    let title: String?
    let description: String?
    let productData: [Product]?
    let completeTheLookHeader: CompleteTheLookHeader?
    let completeTheLookModel: [CompleteTheLookModel]?
}

struct StoriesForYou: Codable {
   
    let largeImage: String
    
    let smallImage1: String
    let smallImage2: String
    
    let largeImageLabel1: String
    let largeImageLabel2: String
    
    let smallImage1Label1: String
    let smallImage1Label2: String
    
    let smallImage2Label1: String
    let smallImage2Label2: String
    
    let title: String
    let rightButtonTitle: String
    let bottomButtonTitle: String
    
    let fullDescription: String?
}

//MARK: - Shop
struct ShopSectionsResponse: Codable {
    let buttonsSection: ShopButtonsModel
    let men: ShopVCMenModels
    let women: ShopVCWomenModels
    let kids: ShopVCKidsModels
}

struct ShopVCMenModels: Codable {
    let newThisWeekSection: [Product]
    let shopListSection: [Product]
    let titleHeaderModel: Header
    let recentlyViewedSection: [Product]?
    let classicsSpotlight: [Product]?
    let shoesSectionHeader: Header
    let shoesSection: [Product]
    let nikeZoomFly6Header: Header
    let nikeZoomFly6: [Product]
    let rafaelNadalHeader: Header
    let rafaelNadal: [Product]
    let clothingHeader: Header
    let clothing: [Product]
    let nearbyStoresHeader: Header
    let nearbyStores: [Product]
    let jacketsHeader: Header
    let jackets: [Product]
}

struct ShopVCWomenModels: Codable {
    let newThisWeekHeader: Header
    let newThisWeekSection: [Product]
    let shopListSection: [Product]
    let facesOfInspirationHeader: Header
    let facesOfInspiration: [Product]
    let recentlyViewedSection: [Product]
    let recentlyViewedHeader: Header
    let classicsSpotlightHeader: Header
    let classicsSpotlight: [Product]
    let jordanSneakersHeader: Header
    let jordanSneakersSection: [Product]
    let nearbyStoresHeader: Header
    let nearbyStores: [Product]
}

struct ShopVCKidsModels: Codable {
    let newThisWeekSection: [Product]
    let shopListSection: [Product]
    let titleHeaderModel: Header
    let recentlyViewedSection: [Product]?
    let classicsSpotlight: [Product]?
    let jordanKidsHeaderModel: Header
    let jordanKids: [Product]
    let nikeNewsHeader: Header
    let nikeNews: [Product]
    let pinkNikeHeader: Header
    let pinkNike: [Product]
}

struct ShopButtonsModel: Codable {
    let firstButtonTitle: String
    let secondButtonTitle: String
    let thirdButtonTitle: String
}

//MARK: - Bag
struct BagSectionsResponse: Codable {
    let topPicks: [Product]
    let productModel: [Product]
}

//MARK: - Header
struct Header: Codable {
    let title: String?
    let subtitleLabel: String?
    let buttonTitle: String?
}

struct Product: Codable {
    let id: Int?
    var count: Int?
    let image: String?
    let image2: String?
    let specialImage: String?
    let logoImage: String?
    let description: String?
    let fullDescription: String?
    let type: String?
    let storeHours: String?
    var price: Int?
    let categories: [Categories]?
    let categoryName: String?
    let detailButtonsName: DetailButtonsModel?
    let promo: [Product]?
    let header: Header?
    let productSizeHeader: Header?
    let productSize: [ProductSize]?
    let newArrivalsHeader: Header?
    let newArrivals: [NewArrivals]?
    let productDescription: [ProductDescription]?
    let completeTheLookHeader: CompleteTheLookHeader?
    let completeTheLook: [CompleteTheLookModel]?
    let youMightAlsoLike: [YouMightAlsoLikeModel]?
    let youMightAlsoLikeHeader: YouMightAlsoLikeHeader?
    let verticalProductModel: [VerticalProductModel]?
    let productInfo: [ProductInfo]?
    let descriptionModel: [Description]?
}

struct Categories: Codable {
    let id: Int?
    let categoryImage: String?
    let subCategories: [SubCategoryModel]?
}

struct SubCategoryModel: Codable {
    let id: Int?
    var subCategoryImage: String?
    let title: String?
    let category: String?
    var count: Double?
    var price: Double?
    var isHeartFilled: Bool?
}

struct DetailButtonsModel: Codable {
    let firstButtonTitle: String?
    let secondButtonTitle: String?
}

struct PromotionModel: Codable {
    let label: String?
}

struct ProductDescription: Codable {
    let description: String?
}

struct ProductSize: Codable {
    let size: String?
}

struct CompleteTheLookModel: Codable {
    let image: String
}

struct CompleteTheLookHeader: Codable {
    let title: String
}

struct YouMightAlsoLikeModel: Codable {
    let image: String
}

struct YouMightAlsoLikeHeader: Codable {
    let title: String
}

struct NewArrivals: Codable {
    let image: String
}

struct VerticalProductModel: Codable {
    let image: String?
}

struct ProductInfo: Codable {
    let title: String?
    let description: String?
    let image: String?
}

struct Description: Codable {
    let description: String
    let type: String
}














