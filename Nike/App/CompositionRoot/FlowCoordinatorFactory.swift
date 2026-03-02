//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import Foundation
import AppInterface
import AppCore
import FeatureAssembly

public final class FlowCoordinatorFactory: FlowCoordinatorFactoryProtocol {
    
    private let dependencies: AppDependenciesProtocol
    
    public init(dependencies: AppDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    public func makeRootFlow(flowType: RootFlowType, config: AppConfiguration) -> RootFlowFactoryProtocol {
        
        switch flowType {
        case .tabBar:
            return TabBarRootFactory(dependencies: dependencies, configuration: config)
        }
    }
}


