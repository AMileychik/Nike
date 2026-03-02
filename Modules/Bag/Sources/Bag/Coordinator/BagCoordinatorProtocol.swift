//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/23/25.
//

import AppInterface

public protocol BagCoordinatorProtocol: AnyObject, CoordinatorProtocol {
    func presentComingSoonVC()
    func showQuantityPicker(for model: BagProductUIModel)
}
