//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

public protocol BagCoordinatorFactoryProtocol: AnyObject {
    func makeBagCoordinator(navigationController: UINavigationController) -> BagCoordinatorProtocol
}


