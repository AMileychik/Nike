//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/30/25.
//

import Bag
import Home
import AppInterface
import FeatureAssembly

public protocol AppDependenciesProtocol: AnyObject {
    var container: DependencyContainerProtocol { get }
    var home: FeatureModuleProtocol { get }
    var bag: FeatureModuleProtocol { get }
    var uiComponentsFactory: BagUIComponentsFactoryProtocol { get }
}
