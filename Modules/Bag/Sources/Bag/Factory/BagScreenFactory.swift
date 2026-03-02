//
//  File.swift
//
//
//  Created by Александр Милейчик on 10/13/25.
//

import UIKit
import DesignSystem
import AppInterface
import SharedUI

public final class BagScreenFactory: BagScreenFactoryProtocol, ScreenFactoryProtocol {
    
    private let uiComponentsFactory: BagUIComponentsFactoryProtocol
    
    public init(uiComponentsFactory: BagUIComponentsFactoryProtocol){
        self.uiComponentsFactory = uiComponentsFactory
    }
    
    public func createBagScreen(viewModel: BagViewModelProtocol) -> (UIViewController & BagViewDisplayingProtocol) {
        
        let tableView = uiComponentsFactory.makeTableView(viewModel: viewModel)
        let buttonsView = uiComponentsFactory.makeBagButtonsView(types: [BagButtonType.pay, BagButtonType.checkout])
        
        let bagVC = BagViewController(viewModel: viewModel, bagTableView: tableView, buttonsView: buttonsView)
        return bagVC
    }
    
    public func createComingSoonScreen() -> UIViewController {
        return ComingSoonViewController()
    }
    
    public func createQuantityPickerViewController() -> QuantityPickerViewController {
        return QuantityPickerViewController()
    }
}
