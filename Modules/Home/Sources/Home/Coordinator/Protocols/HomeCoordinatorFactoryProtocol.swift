//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit
import AppInterface
import Detail

public protocol HomeCoordinatorFactoryProtocol: AnyObject {
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator
}
