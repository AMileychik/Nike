//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import UIKit
import AppInterface
import AppCore
import FeatureAssembly

public struct AppLauncher {
    
    public static func startApp(in window: UIWindow, dependencies: AppDependenciesProtocol, flowType: RootFlowType) {
        
        let config = AppConfigurationFactory.make(flowType: flowType, featureService: dependencies.container.featureToggleService)
       
        let flowFactory = FlowCoordinatorFactory(dependencies: dependencies)
        
        let moduleFactory = AppModuleFactory(config: config, flowFactory: flowFactory)

        let coordinator = AppCoordinator(window: window,rootFactory: moduleFactory.makeRootFlow())
        coordinator.start()
    }
}


