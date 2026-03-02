//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import Bag
import Home
import Detail
import AppComposition
import AppInterface
import FeatureAssembly


public final class AppDependencies: AppDependenciesProtocol {
   
    private let assembly: FeatureAssemblyProtocol
    
    public let container: DependencyContainerProtocol
    
    public let uiComponentsFactory: BagUIComponentsFactoryProtocol
    public let homeUiComponentsFactory: HomeUIComponentsFactoryProtocol
    public let detailUiComponentsFactory: DetailUIComponentsFactoryProtocol
    
    public let home: FeatureModuleProtocol
    public let bag: FeatureModuleProtocol

    public init() {
        container = DependencyContainerFactory.makeDefault()
        uiComponentsFactory = BagUIComponentsFactory()
        homeUiComponentsFactory = HomeUIComponentsFactory()
        detailUiComponentsFactory = DetailUIComponentsFactory()
        
        assembly = FeatureAssembly(container: container, 
                                   uiComponentsFactory: uiComponentsFactory, 
                                   homeUiComponentsFactory: homeUiComponentsFactory, 
                                   detailUiComponentsFactory: detailUiComponentsFactory)
        
        home = assembly.makeHomeFeature()
        bag  = assembly.makeBagFeature()
    }
}
