//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

import AppDomain

public struct PromoProvider: HomeSectionProviderProtocol {

    public let priority = HomeSectionPriority.promo
    
    public init() {}

    public func makeSection(
        from response: HomeSectionsResponse
    ) -> HomeSectionModel? {

        guard !response.promo.isEmpty else { return nil }
        let model = PromoSectionModel(products: response.promo)

        return HomeSectionModel(
            type: .promo,
            data: .promo(model)
        )
    }
}
