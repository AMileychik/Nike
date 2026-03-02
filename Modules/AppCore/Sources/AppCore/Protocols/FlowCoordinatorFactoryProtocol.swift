//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import Foundation
//import AppCore

public protocol FlowCoordinatorFactoryProtocol {
    func makeRootFlow(
        flowType: RootFlowType,
        config: AppConfiguration
    ) -> RootFlowFactoryProtocol
}
