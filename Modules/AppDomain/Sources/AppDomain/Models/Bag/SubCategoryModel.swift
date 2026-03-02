//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct SubCategoryModel: Codable {
    
    public let id: Int?
    public var subCategoryImage: String?
    public let title: String?
    public let category: String?
    public var count: Double?
    public var price: Double?
    public var isHeartFilled: Bool?
    
    public init(id: Int?,
                subCategoryImage: String?,
                title: String?,
                category: String?,
                count: Double?,
                price: Double?,
                isHeartFilled: Bool?)
    {
        self.id = id
        self.subCategoryImage = subCategoryImage
        self.title = title
        self.category = category
        self.count = count
        self.price = price
        self.isHeartFilled = isHeartFilled
    }
}



