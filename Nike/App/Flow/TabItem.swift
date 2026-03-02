//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppCore
import AppInterface
import Bag
import Home
import FeatureAssembly

public enum TabItem: CaseIterable {
    case home
    case bag
    
    public static func availableTabs(config: AppConfiguration) -> [TabItem] {
        var tabs: [TabItem] = []
        if config.bool(.home) { tabs.append(.home) }
        if config.bool(.bag) { tabs.append(.bag) }
        return tabs
    }
    
    public var title: String {
        switch self {
        case .home: return "Home"
        case .bag: return "Bag"
        }
    }
    
    public var image: String {
        switch self {
        case .home: return "house"
        case .bag: return "bag"
        }
    }
    
    public func createViewController(from dependencies: AppDependenciesProtocol,
                                     onCoordinatorCreated: @escaping (CoordinatorProtocol) -> Void) -> UIViewController {
        switch self {
            
        case .home:
            return makeCoordinatorTab(using: dependencies.home.makeCoordinator,
                                      onCoordinatorCreated: onCoordinatorCreated)
            
        case .bag:
            return makeCoordinatorTab(using: dependencies.bag.makeCoordinator,
                                      onCoordinatorCreated: onCoordinatorCreated)
        }
    }
    
    private func makeCoordinatorTab(using factory: (UINavigationController) -> CoordinatorProtocol,
                                    onCoordinatorCreated: (CoordinatorProtocol) -> Void) -> UIViewController {
        
        let nav = UINavigationController()
        let coordinator = factory(nav)
        onCoordinatorCreated(coordinator)
        nav.viewControllers = [coordinator.start()]
        return nav
    }
}













