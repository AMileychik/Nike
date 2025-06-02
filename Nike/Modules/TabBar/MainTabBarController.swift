//
//  MainTabBarController.swift
//  Nike
//
//  Created by Александр Милейчик on 10/9/24.
//

import UIKit

protocol Scrollable {
    func scrollToTop()
}

class MainTabBarController: UITabBarController {

    private let screenFactory: ScreenFactoryProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private var coordinators: [Coordinator] = [] 
    private var lastSelectedIndex: Int?

    init(screenFactory: ScreenFactoryProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol)
    {
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabs()
    }

    private func configureTabs() {
        viewControllers = TabItem.allCases.enumerated().map { index, tabItem in
            let vc = tabItem.createViewController(
                screenFactory: screenFactory,
                coordinatorFactory: coordinatorFactory,
                onCoordinatorCreated: { [weak self] coordinator in
                    guard let self = self else { return }
                    self.coordinators.append(coordinator)
                }
            )

            vc.tabBarItem = UITabBarItem(
                title: tabItem.title,
                image: UIImage(systemName: tabItem.image),
                tag: index
            )
            AppearanceConfigurator.configureTabBarItemAppearance(for: vc.tabBarItem)
            return vc
        }

        selectedIndex = 1
    }
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let currentIndex = tabBarController.selectedIndex

        if lastSelectedIndex == currentIndex,
           let nav = viewController as? UINavigationController,
           let scrollable = nav.viewControllers.first as? Scrollable {
            scrollable.scrollToTop()
        }
        lastSelectedIndex = currentIndex
    }
}
