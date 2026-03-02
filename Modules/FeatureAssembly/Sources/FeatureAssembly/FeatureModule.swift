//
//  FeatureModule.swift
//  Nike
//
//  Created by Александр Милейчик on 10/15/25.
//

import AppInterface
import UIKit

public protocol FeatureModuleProtocol: AnyObject {
    var viewModelFactory: ViewModelFactoryProtocol { get }
    var screenFactory: ScreenFactoryProtocol { get }
    var makeCoordinator: (UINavigationController) -> CoordinatorProtocol { get }
}

public final class FeatureModule: FeatureModuleProtocol {
    
    public let viewModelFactory: ViewModelFactoryProtocol
    public let screenFactory: ScreenFactoryProtocol
    public let makeCoordinator: (UINavigationController) -> CoordinatorProtocol
    
    public init(viewModelFactory: ViewModelFactoryProtocol,
                screenFactory: ScreenFactoryProtocol,
                makeCoordinator: @escaping (UINavigationController) -> CoordinatorProtocol) {
        
        self.viewModelFactory = viewModelFactory
        self.screenFactory = screenFactory
        self.makeCoordinator = makeCoordinator
    }
}
