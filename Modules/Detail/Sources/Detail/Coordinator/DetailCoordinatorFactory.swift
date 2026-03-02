//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/1/25.
//

import UIKit
import AppInterface

public final class DetailCoordinatorFactory: DetailCoordinatorFactoryProtocol, CoordinatorFactoryProtocol {
    
    public let screenFactory: DetailScreenFactoryProtocol
    public let viewModelFactory: DetailViewModelFactoryProtocol
    
    public init(screenFactory: DetailScreenFactoryProtocol,
         viewModelFactory: DetailViewModelFactoryProtocol) {
        self.screenFactory = screenFactory
        self.viewModelFactory = viewModelFactory
    }
    
    public func makeDetailCoordinator(navigationController: UINavigationController) -> DetailCoordinator {
        return DetailCoordinator(viewModelFactory: viewModelFactory, screenFactory: screenFactory, navigationController: navigationController)
    }
}
