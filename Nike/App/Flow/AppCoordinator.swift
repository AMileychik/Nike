//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import UIKit
import AppInterface

public final class AppCoordinator {
    
    private let window: UIWindow
    private let rootFactory: RootFlowFactoryProtocol

    public init(window: UIWindow, rootFactory: RootFlowFactoryProtocol) {
        self.window = window
        self.rootFactory = rootFactory
    }

    public func start() {
        let rootVC = rootFactory.makeRootViewController()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
}
