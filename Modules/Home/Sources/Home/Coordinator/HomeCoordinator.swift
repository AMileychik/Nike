//
//  File.swift
//
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit

import Combine

import AppDomain
import AppInterface
import Detail

// MARK: - HomeCoordinator

/// Coordinates navigation and module setup for the Home feature.
///
/// Responsibilities:
/// - Creates and configures the Home module (ViewController + ViewModel + Binder).
/// - Handles navigation to detail screens and “Coming Soon” screens.
public final class HomeCoordinator {
    
    // MARK: - Properties
    
    /// External dependencies required to build modules and configure navigation.
    private let dependencies: HomeCoordinatorDependencies
    
    /// Binder coordinating Home module bindings.
    private var binder: HomeBinderProtocol?
    
    /// Child coordinator for detail screens.
    private var detailCoordinator: DetailCoordinator?
    
    /// The root view controller of the Home module.
    private weak var rootViewController: UIViewController?
    
    /// Navigation controller used for all Home-related navigation.
    public let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    public init(
        dependencies: HomeCoordinatorDependencies,
        navigationController: UINavigationController
    ) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol

extension HomeCoordinator: CoordinatorProtocol {
    
    /// Starts the Home module.
    public func start() -> UIViewController {
        let (homeViewController, viewModel) = makeHomeModule()
        bind(viewController: homeViewController,viewModel: viewModel)
        
        dependencies.navigationConfigurator.configure(
            navigationController: navigationController,
            rootViewController: homeViewController,
            viewBinder: binder?.viewBinder
        )
        
        rootViewController = homeViewController
        return homeViewController
    }
}

// MARK: - Module Creation

private extension HomeCoordinator {
    
    /// Creates the Home module (ViewController + ViewModel)
    private func makeHomeModule()
    -> (UIViewController & HomeViewDisplayingProtocol, HomeViewModelProtocol)
    {
        let viewModel = makeHomeViewModel()
        let viewController = makeHomeViewController(viewModel: viewModel)
        return (viewController, viewModel)
    }
    
    /// Creates the Home ViewModel using the factory and dependencies
    private func makeHomeViewModel() -> HomeViewModelProtocol {
        let deps = dependencies
        return deps.viewModelFactory.makeHomeViewModel(
            sectionBuilder: deps.sectionBuilder,
            errorMapper: deps.errorMapperFactory.makeErrorMapper()
        )
    }
    
    /// Creates the Home ViewController using the factory
    private func makeHomeViewController(
        viewModel: HomeViewModelProtocol
    ) -> UIViewController & HomeViewDisplayingProtocol {
        dependencies.screenFactory.createHomeScreen(viewModel: viewModel)
    }
}

// MARK: - Binding

private extension HomeCoordinator {
    
    /// Binds the Home module with its ViewModel and sets up the binder.
    private func bind(
        viewController: UIViewController & HomeViewDisplayingProtocol,
        viewModel: HomeViewModelProtocol
    ) {
        let binder = dependencies.binderFactory.makeBinder(
            viewModel: viewModel,
            viewController: viewController,
            router: self
        )
        
        self.binder = binder
        binder.bind()
    }
}


// MARK: - Navigation

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    /// Navigates to a detail screen with provided data.
    public func showDetail(data: DetailData) {
        let coordinator = dependencies.detailCoordinatorFactory
            .makeDetailCoordinator(navigationController: navigationController)
        
        self.detailCoordinator = coordinator
        let detailVC = coordinator.start(with: data)
        
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    /// Presents a “Coming Soon” screen modally.
    public func showComingSoon() {
        let viewController = dependencies.screenFactory
            .createComingSoonScreen()
        
        viewController.modalPresentationStyle = .fullScreen
        rootViewController?.present(viewController, animated: true)
    }
}
