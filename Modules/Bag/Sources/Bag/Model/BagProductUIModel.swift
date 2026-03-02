//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/10/25.
//

import Foundation

public struct BagProductUIModel: Decodable {
    public let id: Int?
    public let image: String?
    public let title: String?
    public let category: String?
    public let count: Double?
    public var price: Double?
    public let isHeartFilled: Bool?
    
    public init(id: Int?, image: String?, title: String?, category: String?, count: Double?, price: Double?, isHeartFilled: Bool?) {
        self.id = id
        self.image = image
        self.title = title
        self.category = category
        self.count = count
        self.price = price
        self.isHeartFilled = isHeartFilled
    }
}
