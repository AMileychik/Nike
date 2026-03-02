//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation
import AppDomain

public struct StoriesProvider: HomeSectionProviderProtocol {
    public let priority = HomeSectionPriority.storiesForYou

    public init() {}

    public func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel? {

        guard !response.storiesForYou.isEmpty else { return nil }

        let sectionModel = StoriesForYouModel(
            header: response.storiesForYouHeader,
            products: response.storiesForYou
        )

        return HomeSectionModel(
            type: .storiesForYou,
            data: .storiesForYou(sectionModel)
        )
    }
}
