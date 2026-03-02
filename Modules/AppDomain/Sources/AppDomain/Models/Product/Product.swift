//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct Product: Codable {
    public let id: Int?
    public var count: Int?
    public let image: String?
    public let image2: String?
    public let specialImage: String?
    public let logoImage: String?
    public let description: String?
    public let fullDescription: String?
    public let type: String?
    public let storeHours: String?
    public var price: Int?
    public let categories: [Categories]?
    public let categoryName: String?
    public let detailButtonsName: DetailButtonsModel?
    public let promo: [Product]?
    public let header: Header?
    public let productSizeHeader: Header?
    public let productSize: [ProductSize]?
    public let newArrivalsHeader: Header?
    public let newArrivals: [NewArrivals]?
    public let productDescription: [ProductDescription]?
    public let completeTheLookHeader: CompleteTheLookHeader?
    public let completeTheLook: [CompleteTheLookModel]?
    public let youMightAlsoLike: [YouMightAlsoLikeModel]?
    public let youMightAlsoLikeHeader: YouMightAlsoLikeHeader?
    public let verticalProductModel: [VerticalProductModel]?
    public let productInfo: [ProductInfo]?
    public let descriptionModel: [Description]?
    
    public init(
        id: Int?, count: Int?, image: String?, image2: String?, specialImage: String?,
        logoImage: String?, description: String?, fullDescription: String?, type: String?,
        storeHours: String?, price: Int?, categories: [Categories]?, categoryName: String?,
        detailButtonsName: DetailButtonsModel?, promo: [Product]?, header: Header?,
        productSizeHeader: Header?, productSize: [ProductSize]?, newArrivalsHeader: Header?,
        newArrivals: [NewArrivals]?, productDescription: [ProductDescription]?,
        completeTheLookHeader: CompleteTheLookHeader?, completeTheLook: [CompleteTheLookModel]?,
        youMightAlsoLike: [YouMightAlsoLikeModel]?, youMightAlsoLikeHeader: YouMightAlsoLikeHeader?,
        verticalProductModel: [VerticalProductModel]?, productInfo: [ProductInfo]?,
        descriptionModel: [Description]?
    ) {
        self.id = id
        self.count = count
        self.image = image
        self.image2 = image2
        self.specialImage = specialImage
        self.logoImage = logoImage
        self.description = description
        self.fullDescription = fullDescription
        self.type = type
        self.storeHours = storeHours
        self.price = price
        self.categories = categories
        self.categoryName = categoryName
        self.detailButtonsName = detailButtonsName
        self.promo = promo
        self.header = header
        self.productSizeHeader = productSizeHeader
        self.productSize = productSize
        self.newArrivalsHeader = newArrivalsHeader
        self.newArrivals = newArrivals
        self.productDescription = productDescription
        self.completeTheLookHeader = completeTheLookHeader
        self.completeTheLook = completeTheLook
        self.youMightAlsoLike = youMightAlsoLike
        self.youMightAlsoLikeHeader = youMightAlsoLikeHeader
        self.verticalProductModel = verticalProductModel
        self.productInfo = productInfo
        self.descriptionModel = descriptionModel
    }
}
