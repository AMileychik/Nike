//
//  AppDependencies.swift
//  Nike
//
//  Created by Александр Милейчик on 5/31/25.
//

import Foundation

protocol AppDependenciesProtocol: AnyObject {
    var container: DependencyContainerProtocol { get }
    var viewModelFactory: ViewModelFactoryProtocol { get }
    var presenterFactory: ShopPresenterFactoryProtocol { get }
    var screenFactory: ScreenFactoryProtocol { get }
    var coordinatorFactory: CoordinatorFactoryProtocol { get }
}

final class AppDependencies: AppDependenciesProtocol {
    
    let container: DependencyContainerProtocol
    let viewModelFactory: ViewModelFactoryProtocol
    let presenterFactory: ShopPresenterFactoryProtocol
    let screenFactory: ScreenFactoryProtocol
    let coordinatorFactory: CoordinatorFactoryProtocol

    init() {
        self.container = DependencyContainer.makeDefault()
        self.viewModelFactory = ViewModelFactory(container: container)
        self.presenterFactory = ShopPresenterFactory(container: container)
        self.screenFactory = ScreenFactory(viewModelFactory: viewModelFactory, presenterFactory: presenterFactory)
        self.coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
    }
}
