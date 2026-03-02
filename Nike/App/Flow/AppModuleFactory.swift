//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppInterface
import AppCore

public final class AppModuleFactory: ModuleFactoryProtocol {

    private let config: AppConfiguration
    private let flowFactory: FlowCoordinatorFactoryProtocol

    public init(config: AppConfiguration, flowFactory: FlowCoordinatorFactoryProtocol) {
        self.config = config
        self.flowFactory = flowFactory
    }

    public func makeRootFlow() -> RootFlowFactoryProtocol {
        return flowFactory.makeRootFlow(flowType: config.flowType, config: config)
    }
}
