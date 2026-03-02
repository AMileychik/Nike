//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public struct SwiftStrideProvider: HomeSectionProviderProtocol {
    
    public let priority = 6

    public init() {}
    
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        guard !response.nikeSwiftAndStride .isEmpty else { return nil }

        let model = BecauseYouLikeModel(header: response.nikeSwiftAndStrideHeader, products: response.nikeSwiftAndStride)

        return HomeSectionModel(type: .becauseYouLike, data: .becauseYouLike(model))
    }
}
