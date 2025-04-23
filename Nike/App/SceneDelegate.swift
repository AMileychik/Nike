//
//  SceneDelegate.swift
//  Nike
//
//  Created by Александр Милейчик on 9/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupWindow(windowScene)
    }
    
    private func setupWindow(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        setupNavigationBarAppearance()
        setupTabBarAppearance()
        
        let tabBarController = TabBarController()
        setupTabBarItems(tabBarController)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = .white
        navigationBarAppearance.shadowImage = UIImage()
    }
    
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = .white
        tabBarAppearance.shadowImage = UIImage()
        tabBarAppearance.isTranslucent = false
        tabBarAppearance.backgroundImage = UIImage()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.tintColor = .black
    }
    
    private func setupTabBarItems(_ tabBarController: TabBarController) {
        tabBarController.viewControllers?.forEach { viewController in
            viewController.tabBarItem.setTitleTextAttributes(
                [.foregroundColor: UIColor.lightGray],
                for: .normal
            )
            viewController.tabBarItem.setTitleTextAttributes(
                [.foregroundColor: UIColor.black],
                for: .selected
            )
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

