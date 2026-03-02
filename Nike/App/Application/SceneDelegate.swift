//
//  SceneDelegate.swift
//  Nike
//
//  Created by Александр Милейчик on 9/27/24.
//

import UIKit
import AppComposition
import SharedUI
import AppInterface
import FeatureAssembly
import Bag

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var dependencies: AppDependenciesProtocol = AppDependencies()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        AppearanceConfigurator.configure()

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        configureFeatureFlags()
        restartApp()
    }

    private func configureFeatureFlags() {
        dependencies.container.featureToggleService.onFlagsChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.restartApp()
            }
        }

        dependencies.container.featureToggleService.updateFlags(
            isBagFeatureEnabled: true,
            isHomeFeatureEnabled: true
        )
    }

    private func restartApp() {
        guard let window = window else { return }
        AppLauncher.startApp(
            in: window,
            dependencies: dependencies,
            flowType: .tabBar
        )
    }
}
