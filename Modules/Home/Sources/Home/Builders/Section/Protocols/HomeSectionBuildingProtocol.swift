//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/6/26.
//

import AppDomain

// MARK: - HomeSectionBuildingProtocol

public protocol HomeSectionBuildingProtocol {
    func buildSections(from response: HomeSectionsResponse) -> [HomeSectionModel]
}
