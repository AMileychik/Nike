//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/5/25.
//

import Foundation
import AppInterface
import AppDomain

public final class FeatureToggleUserDefaultsRepository: FeatureToggleRepositoryProtocol {
   
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "FeatureFlagsKey"
    
    public init() {}

    public func loadFlags() -> FeatureFlagsModel {
        guard let data = UserDefaults.standard.data(forKey: key),
              let model = try? decoder.decode(FeatureFlagsModel.self, from: data) else {
            
            return FeatureFlagsModel(isBagEnabled: true, isHomeEnabled: true)
        }
        return model
    }

    public func saveFlags(_ model: FeatureFlagsModel) {
        guard let data = try? encoder.encode(model) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
