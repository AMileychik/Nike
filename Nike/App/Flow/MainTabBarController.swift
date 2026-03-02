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

public final class MainTabBarController: UITabBarController {
    
    private let dependencies: AppDependenciesProtocol
    private let configuration: AppConfiguration
    
    private var coordinators: [CoordinatorProtocol] = []
    private var lastSelectedIndex: Int?
    
    public init(dependencies: AppDependenciesProtocol, configuration: AppConfiguration) {
        self.dependencies = dependencies
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabs()
    }
    
    private func configureTabs() {
        let availableTabs = TabItem.availableTabs(config: configuration)
        
        viewControllers = availableTabs.enumerated().map { index, tab in
            let vc = tab.createViewController(from: dependencies) { [weak self] coordinator in
                self?.coordinators.append(coordinator)
            }
            
            vc.tabBarItem = UITabBarItem(
                title: tab.title,
                image: UIImage(systemName: tab.image),
                tag: index
            )
            return vc
        }
        
        selectedIndex = 0
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let currentIndex = tabBarController.selectedIndex
        if lastSelectedIndex == currentIndex,
           let nav = viewController as? UINavigationController,
           let scrollable = nav.viewControllers.first as? Scrollable {
            scrollable.scrollToTop()
        }
        lastSelectedIndex = currentIndex
    }
}

