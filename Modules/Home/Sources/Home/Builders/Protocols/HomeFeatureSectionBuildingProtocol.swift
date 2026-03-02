//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public protocol HomeFeatureSectionBuildingProtocol {
    func build(from domain: HomeSectionModel) -> HomeFeatureSection
}
