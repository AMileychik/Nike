//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/5/25.
//

import AppDomain

public protocol FeatureToggleRepositoryProtocol {
    func loadFlags() -> FeatureFlagsModel
    func saveFlags(_ flags: FeatureFlagsModel)
}
