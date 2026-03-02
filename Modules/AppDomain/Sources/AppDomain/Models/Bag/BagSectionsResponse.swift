//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct BagSectionsResponse: Codable {
    public let topPicks: [Product]
    public let productModel: [Product]
    
    public init(
        topPicks: [Product],
        productModel: [Product]
    ) {
        self.topPicks = topPicks
        self.productModel = productModel
    }
}
