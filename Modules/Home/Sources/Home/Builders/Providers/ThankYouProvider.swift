//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation

import AppDomain

public struct ThankYouProvider: HomeSectionProviderProtocol {
    public let priority = HomeSectionPriority.thankYou

    public init() {}
    
    public func makeSection(
        from response: HomeSectionsResponse
    ) -> HomeSectionModel? {
             
        guard response.thankYou != nil else { return nil }
        
        return HomeSectionModel(
            type: .thankYou,
            data: .thankYou(response.thankYou))
    }
}
