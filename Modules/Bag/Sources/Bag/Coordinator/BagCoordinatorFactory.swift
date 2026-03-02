//
//  File.swift
//
//
//  Created by Александр Милейчик on 10/13/25.
//

import UIKit
import AppInterface

public final class BagCoordinatorFactory: BagCoordinatorFactoryProtocol, CoordinatorFactoryProtocol {
    
    private let screenFactory: BagScreenFactoryProtocol
    private let viewModelFactory: BagViewModelFactoryProtocol
    private let uiComponentsFactory: BagUIComponentsFactoryProtocol
    
    public init(screenFactory: BagScreenFactoryProtocol,
                viewModelFactory: BagViewModelFactoryProtocol,
                uiComponentsFactory: BagUIComponentsFactoryProtocol)
    {
        self.screenFactory = screenFactory
        self.viewModelFactory = viewModelFactory
        self.uiComponentsFactory = uiComponentsFactory
    }
    
    public func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinatorProtocol {
        BagCoordinator(viewModelFactory: viewModelFactory, screenFactory: screenFactory, uiComponentsFactory: uiComponentsFactory)
    }
}
