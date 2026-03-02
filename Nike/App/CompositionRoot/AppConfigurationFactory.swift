//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import AppCore
import AppInterface

// MARK: - AppConfigurationFactory

/// Factory for creating app-wide configuration objects.
///
/// Responsible for generating `AppConfiguration` instances based on:
/// - The root flow type (e.g., tabBar, onboarding)
/// - Current feature flags provided by the `FeatureToggleServiceProtocol`
public enum AppConfigurationFactory {
    
    // MARK: - Public Factory Method
    
    /// Creates an `AppConfiguration` for the app.
    ///
    /// - Parameters:
    ///   - flowType: The root flow type that the app should start with.
    ///   - featureService: Service providing feature toggle flags.
    /// - Returns: A fully configured `AppConfiguration` instance.
    public static func make(
        flowType: RootFlowType,
        featureService: FeatureToggleServiceProtocol
    ) -> AppConfiguration {
        return AppConfiguration(
            flowType: flowType,
            featureFlags: [
                .home: featureService.isHomeFeatureEnabled,
                .bag: featureService.isBagFeatureEnabled,
            ]
        )
    }
}
