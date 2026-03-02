//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public struct NewFromNikeSectionModel {
    public let header: Header
    public let products: [NewFromNikeModel]
    
    public init(header: Header, products: [NewFromNikeModel]) {
        self.header = header
        self.products = products
    }

    var rowHeights: [CGFloat] {
        products.map {
            $0.videoURL != nil ? 250 : 500
        }
    }

    var gradientIndexes: [Int] {
        guard !products.isEmpty else { return [] }
        return [products.count - 1]
    }
}
