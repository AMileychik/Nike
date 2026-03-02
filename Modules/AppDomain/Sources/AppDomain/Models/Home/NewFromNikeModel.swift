//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct NewFromNikeModel: Codable {
    public let videoURL: String?
    public let image: String?
    public let logoTitle: String?
    public let detailImage: String?
    public let title: String?
    public let description: String?
    public let productData: [Product]?
    public let completeTheLookHeader: CompleteTheLookHeader?
    public let completeTheLookModel: [CompleteTheLookModel]?
    
    public init(
        videoURL: String?,
        image: String?,
        logoTitle: String?,
        detailImage: String?,
        title: String?,
        description: String?,
        productData: [Product]?,
        completeTheLookHeader: CompleteTheLookHeader?,
        completeTheLookModel: [CompleteTheLookModel]?
    ) {
        self.videoURL = videoURL
        self.image = image
        self.logoTitle = logoTitle
        self.detailImage = detailImage
        self.title = title
        self.description = description
        self.productData = productData
        self.completeTheLookHeader = completeTheLookHeader
        self.completeTheLookModel = completeTheLookModel
    }
}
