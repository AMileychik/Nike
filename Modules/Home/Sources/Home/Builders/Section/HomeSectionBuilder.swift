//
//  HomeSectionBuilder.swift
//  Nike
//
//  Created by Александр Милейчик on 4/14/25.
//

import Foundation

import AppDomain

public protocol HomeSectionBuildingProtocol {
    func buildSections(from response: HomeSectionsResponse) -> [HomeSectionModel]
}

public final class HomeSectionBuilder: HomeSectionBuildingProtocol {
   
    private let providers: [HomeSectionProviderProtocol]
    
    public init(providers: [HomeSectionProviderProtocol]) {
        self.providers = providers
    }
    
    public func buildSections(from response: HomeSectionsResponse) -> [HomeSectionModel] {
        providers
            .sorted { $0.priority < $1.priority }
            .compactMap { $0.makeSection(from: response) }
    }
}


