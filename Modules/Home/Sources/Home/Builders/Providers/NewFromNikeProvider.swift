//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/15/25.
//

import Foundation

import AppDomain
import DesignSystem

public struct NewFromNikeProvider: HomeSectionProviderProtocol {

    public let priority = 3
    
    public init() {}

    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {
        guard !response.newFromNike.isEmpty else { return nil }

        let model = NewFromNikeSectionModel(header: response.newFromNikeHeader, products: response.newFromNike)
        return HomeSectionModel(type: .newFromNike, data: .newFromNike(model))
    }
}

