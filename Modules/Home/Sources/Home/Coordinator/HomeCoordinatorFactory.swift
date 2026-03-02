//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit
import AppInterface
import Detail

public final class HomeCoordinatorFactory: HomeCoordinatorFactoryProtocol, CoordinatorFactoryProtocol {
    
    public let screenFactory: HomeScreenFactoryProtocol
    public let viewModelFactory: HomeViewModelFactoryProtocol
    public let detailCoordinatorFctory: DetailCoordinatorFactoryProtocol
    
    public init(screenFactory: HomeScreenFactoryProtocol,
                viewModelFactory: HomeViewModelFactoryProtocol,
                detailCoordinatorFctory: DetailCoordinatorFactoryProtocol)
    {
        self.screenFactory = screenFactory
        self.viewModelFactory = viewModelFactory
        self.detailCoordinatorFctory = detailCoordinatorFctory
    }
    
    public func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
        
        return HomeCoordinator(viewModelFactory: viewModelFactory, screenFactory: screenFactory, homeCoordinatorFactory: self, coordinatorFactory: detailCoordinatorFctory, navigationController: navigationController)
    }
}
