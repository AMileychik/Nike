//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

import UIKit
import DesignSystem

public protocol BagUIComponentsFactoryProtocol: AnyObject {
    func makeBagButtonsView(types: [BagButtonType]) -> (UIView & BagButtonsViewProtocol)
    func makeTableView(viewModel: BagViewModelProtocol) -> (UIView & BagTableViewProtocol)
}
