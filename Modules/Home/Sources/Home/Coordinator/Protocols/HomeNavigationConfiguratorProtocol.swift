//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import UIKit

public protocol HomeNavigationConfiguratorProtocol {
    func configure(
        navigationController: UINavigationController,
        rootViewController: UIViewController,
        viewBinder: ViewBinderProtocol?
    )
}
