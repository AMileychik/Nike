//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/3/25.
//

import Foundation

public protocol ModuleFactoryProtocol {
    func makeRootFlow() -> RootFlowFactoryProtocol
}
