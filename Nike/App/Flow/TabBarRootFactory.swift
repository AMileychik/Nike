//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppInterface
import AppCore
import Home
import Bag
import FeatureAssembly

public final class TabBarRootFactory: RootFlowFactoryProtocol {
    
    private let dependencies: AppDependenciesProtocol
    private let configuration: AppConfiguration
    
    public init(dependencies: AppDependenciesProtocol, configuration: AppConfiguration) {
        self.dependencies = dependencies
        self.configuration = configuration
    }
    
    public func makeRootViewController() -> UIViewController {
        return MainTabBarController(dependencies: dependencies, configuration: configuration)
    }
}


