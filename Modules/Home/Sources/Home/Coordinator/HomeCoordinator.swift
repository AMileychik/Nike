//
//  File.swift
//
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit
import AppDomain
import AppInterface
import Detail
import SharedUI

public final class HomeCoordinator: CoordinatorProtocol, HomeCoordinatorProtocol {
    
    // MARK: - Properties
    public var viewModelFactory: HomeViewModelFactoryProtocol
    public let screenFactory: HomeScreenFactoryProtocol
    public let homeCoordinatorFactory: HomeCoordinatorFactoryProtocol
    public let coordinatorFactory: DetailCoordinatorFactoryProtocol
//    public var homeViewModel: HomeViewModelProtocol?
    public var binder: HomeBinderProtocol?
    public var detailCoordinator: DetailCoordinator?
    private weak var rootViewController: UIViewController?
    public let navigationController: UINavigationController
    
    
    // MARK: - Init
    public init(viewModelFactory: HomeViewModelFactoryProtocol,
                screenFactory: HomeScreenFactoryProtocol,
                homeCoordinatorFactory: HomeCoordinatorFactoryProtocol,
                coordinatorFactory: DetailCoordinatorFactoryProtocol,
                navigationController: UINavigationController)
    {
        self.viewModelFactory = viewModelFactory
        self.navigationController = navigationController
        self.screenFactory = screenFactory
        self.homeCoordinatorFactory = homeCoordinatorFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    // MARK: - Start
    public func start() -> UIViewController {
        let homeViewModel = viewModelFactory.makeHomeViewModel()
        let homeVC = screenFactory.createHomeScreen(viewModel: homeViewModel)
        
 //       self.homeViewModel = homeViewModel

        let binder = HomeBinder(
            viewBinder: ViewBinder(input: homeViewModel, viewController: homeVC), 
            stateHandler: StateHandler(output: homeViewModel, homeScreen: homeVC),
            effectHandler: EffectHandler(output: homeViewModel, router: self))
        
        self.binder = binder
        binder.bind()
        
        navigationController.setViewControllers([homeVC], animated: false)
        
        navigationController.addMagnifyButton(
            target: binder.viewBinder,
            action: #selector(ViewBinder.onSearchButtonTapped)
        )
        
        rootViewController = homeVC
        
        return homeVC
    }
    
    // MARK: - DetailVC
    
    public func showDetail(data: DetailData) {
        let coordinator = coordinatorFactory.makeDetailCoordinator(navigationController: navigationController)
        self.detailCoordinator = coordinator
        let detailVC = coordinator.start(with: data)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    
    public func showComingSoon() {
        let vc = screenFactory.createComingSoonScreen()
        vc.modalPresentationStyle = .fullScreen
        rootViewController?.present(vc, animated: true)
    }
}

