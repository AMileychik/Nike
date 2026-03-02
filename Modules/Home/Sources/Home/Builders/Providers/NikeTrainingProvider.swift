//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public struct NikeTrainingProvider: HomeSectionProviderProtocol {

    public let priority = 4

    public init() {}
    
    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        guard !response.nikeTraining.isEmpty else { return nil }

        let model = BecauseYouLikeModel(header: response.nikeTrainingHeader, products: response.nikeTraining)
        return HomeSectionModel(type: .becauseYouLike, data: .becauseYouLike(model))
    }
}

