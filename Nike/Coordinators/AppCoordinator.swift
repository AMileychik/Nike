//
//  AppCoordinator.swift
//  Nike
//
//  Created by Александр Милейчик on 5/29/25.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private let dependencies: AppDependenciesProtocol

    init(window: UIWindow,
         dependencies: AppDependenciesProtocol)
    {
        self.window = window
        self.dependencies = dependencies
    }

    func start() {
        let tabBarController = MainTabBarController(
            screenFactory: dependencies.screenFactory,
            coordinatorFactory: dependencies.coordinatorFactory
        )
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
