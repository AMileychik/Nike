//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/25/25.
//

import UIKit
import SharedUI

public protocol BagScreenFactoryProtocol: AnyObject {
//    func createBagScreen(viewModel: BagViewModelProtocol) -> UIViewController
    func createBagScreen(viewModel: BagViewModelProtocol) -> (UIViewController & BagViewDisplayingProtocol)
    func createComingSoonScreen() -> UIViewController
    func createQuantityPickerViewController() -> QuantityPickerViewController
}


