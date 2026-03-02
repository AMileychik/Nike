//
//  SceneDelegate.swift
//  Nike
//
//  Created by Александр Милейчик on 9/27/24.
//

import UIKit

// MARK: - SceneDelegate

/// The scene delegate responsible for setting up the application's main window,
/// configuring feature flags, and launching the app's root flow.
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    /// The main window where the app's UI is displayed.
    var window: UIWindow?
    
    /// Provides app-wide dependencies and services.
    private lazy var dependencies: AppDependenciesProtocol = AppDependencies()

    // MARK: - UIScene Lifecycle
    
    /// Called when the scene is being created and connected to a session.
    /// Responsible for configuring the window, applying appearance, feature flags, and starting the app.
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Ensure we have a valid UIWindowScene
        guard let windowScene = scene as? UIWindowScene else { return }

        // Apply global UI appearance configurations (navigation bar, tab bar, etc.)
        AppearanceConfigurator.configure()

        // Initialize the main window
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // Configure feature flags before launching the app
        configureFeatureFlags()

        // Start the app's main flow
        restartApp()
    }

    // MARK: - Feature Flags

    /// Configures feature flags and sets up a listener to restart the app when flags change.
    private func configureFeatureFlags() {
        // Listen for changes in feature flags and restart the app if they change
        dependencies.container.featureToggleService.onFlagsChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.restartApp()
            }
        }

        // Set initial feature flags
        dependencies.container.featureToggleService.updateFlags(
            isBagFeatureEnabled: true,
            isHomeFeatureEnabled: true
        )
    }

    // MARK: - App Launch

    /// Starts the application using the `AppLauncher`.
    private func restartApp() {
        guard let window = window else { return }

        // Launch the app with the main flow type
        AppLauncher.startApp(
            in: window,
            dependencies: dependencies,
            flowType: .tabBar
        )
    }
}
