//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import Foundation

public enum AppFeatureKey: String {
    case home
    case bag
}

public enum RootFlowType {
    case tabBar
    //    case onboarding
}

public struct AppConfiguration {
    
    public let flowType: RootFlowType
    public let featureFlags: [AppFeatureKey: Any]
    
    public init(flowType: RootFlowType, featureFlags: [AppFeatureKey: Any]) {
        self.flowType = flowType
        self.featureFlags = featureFlags
    }
    
    public func bool(_ key: AppFeatureKey) -> Bool {
        (featureFlags[key] as? Bool) ?? false
    }
    
    public func int(_ key: AppFeatureKey) -> Int? {
        featureFlags[key] as? Int
    }
}
