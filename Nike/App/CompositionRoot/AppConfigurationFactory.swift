//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import Foundation
import AppCore
import AppInterface

public enum AppConfigurationFactory {
    
    public static func make(flowType: RootFlowType, featureService: FeatureToggleServiceProtocol) -> AppConfiguration {
      
        return AppConfiguration(flowType: flowType, featureFlags: [
                .home: featureService.isHomeFeatureEnabled,
                .bag: featureService.isBagFeatureEnabled,
            ]
        )
    }
}
