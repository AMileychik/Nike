//
//  MainTabBarController.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/9/24.
//

import UIKit

protocol Scrollable {
    func scrollToTop()
}

let dependencyContainer = DependencyContainer()

class TabBarController: UITabBarController {
    
    private var lastSelectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let screens: [(UIViewController, String, String)] = [
            (dependencyContainer.screenFactory.createShopScreen(), Text.TabBarController.shop, Images.magnifyingglass),
            (dependencyContainer.screenFactory.createHomeScreen(), Text.TabBarController.home, Images.house),
            (dependencyContainer.screenFactory.createFavoriteScreen(), Text.TabBarController.favorite, Images.heart),
            (dependencyContainer.screenFactory.createBagScreen(), Text.TabBarController.bag, Images.bag)
        ]
        
        viewControllers = screens.enumerated().map { index, screen in
            let (viewController, title, image) = screen
            viewController.tabBarItem = createTabBarItem(title: title, systemImageName: image, tag: index)
            return UINavigationController(rootViewController: viewController)
        }
        
        selectedIndex = 1
        delegate = self
    }
    
    private func createTabBarItem(title: String, systemImageName: String, tag: Int) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(systemName: systemImageName), tag: tag)
    }
}

//MARK:- UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let currentIndex = tabBarController.selectedIndex
        
        if lastSelectedIndex == currentIndex,
           let navigationController = viewController as? UINavigationController,
           let scrollableController = navigationController.viewControllers.first as? Scrollable {
            scrollableController.scrollToTop()
        }
        
        lastSelectedIndex = currentIndex
    }
}
