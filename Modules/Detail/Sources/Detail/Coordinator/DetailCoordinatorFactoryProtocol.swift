//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit

public protocol DetailCoordinatorFactoryProtocol: AnyObject {
    func makeDetailCoordinator(navigationController: UINavigationController) -> DetailCoordinator
}

