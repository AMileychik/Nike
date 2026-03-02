//
//  FeatureToggleService.swift
//  Nike
//
//  Created by Александр Милейчик on 7/2/25.
//

import AppInterface
import AppDomain

public final class FeatureToggleService: FeatureToggleServiceProtocol {
    
    public var isBagFeatureEnabled: Bool
    public var isHomeFeatureEnabled: Bool
    
    public var onFlagsChanged: (() -> Void)?
    private let repository: FeatureToggleRepositoryProtocol
    
    public init(repository: FeatureToggleRepositoryProtocol) {
        self.repository = repository
        let flags = repository.loadFlags()
        self.isBagFeatureEnabled = flags.isBagEnabled
        self.isHomeFeatureEnabled = flags.isHomeEnabled
    }
    
    public func updateFlags(
        isBagFeatureEnabled: Bool? = nil,
        isHomeFeatureEnabled: Bool? = nil
    ) {
        var didChange = false
        
        if let value = isHomeFeatureEnabled, value != self.isHomeFeatureEnabled {
            self.isHomeFeatureEnabled = value
            didChange = true
        }
        
        if let value = isBagFeatureEnabled, value != self.isBagFeatureEnabled {
            self.isBagFeatureEnabled = value
            didChange = true
        }
        
        if didChange {
            let model = FeatureFlagsModel(
                isBagEnabled: self.isBagFeatureEnabled,
                isHomeEnabled: self.isHomeFeatureEnabled
            )
            
            repository.saveFlags(model)
            onFlagsChanged?()
        }
    }
}
