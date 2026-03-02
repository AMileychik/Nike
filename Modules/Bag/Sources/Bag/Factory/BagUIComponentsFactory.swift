//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

import UIKit
import DesignSystem

public final class BagUIComponentsFactory: BagUIComponentsFactoryProtocol {
    
    public init() {}
    
    public func makeBagButtonsView(types: [BagButtonType]) -> (UIView & BagButtonsViewProtocol) {
        return BagButtonsView(types: types)
    }

    public func makeTableView(viewModel: BagViewModelProtocol) -> (UIView & BagTableViewProtocol) {
        BagTableView(viewModel: viewModel)
    }
}

