//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

import UIKit
import AppDomain
import SharedUI
import DesignSystem

public final class BagCoordinator: BagCoordinatorProtocol {
    
    public var viewModelFactory: BagViewModelFactoryProtocol
    private let screenFactory: BagScreenFactoryProtocol
    private let uiComponentsFactory: BagUIComponentsFactoryProtocol
    public var binder: BagBinderProtocol?
    public var bagViewModel: BagViewModelProtocol?
    private var currentEditingModel: BagProductUIModel?
    private weak var rootViewController: UIViewController?
    
    public init(viewModelFactory: BagViewModelFactoryProtocol,
                screenFactory: BagScreenFactoryProtocol,
                uiComponentsFactory: BagUIComponentsFactoryProtocol)
    {
        self.viewModelFactory = viewModelFactory
        self.screenFactory = screenFactory
        self.uiComponentsFactory = uiComponentsFactory
    }
    
    public func start() -> UIViewController {
        let bagViewModel = viewModelFactory.makeBagViewModel()
        let bagVC = screenFactory.createBagScreen(viewModel: bagViewModel)
        
        self.bagViewModel = bagViewModel
        
        let binder = BagBinder(
            viewBinder: ViewBinder(input: bagViewModel, actions: bagVC.bagButtonsView),
            stateHandler: StateHandler(output: bagViewModel, bagScreen: bagVC),
            effectHandler: EffectHandler(output: bagViewModel, router: self))
        
        self.binder = binder
        binder.bind()
        
        rootViewController = bagVC
        return bagVC
    }
    
    public func presentComingSoonVC() {
        let vc = screenFactory.createComingSoonScreen()
        vc.modalPresentationStyle = .fullScreen
        rootViewController?.present(vc, animated: true)
    }
    
    public func showQuantityPicker(for model: BagProductUIModel) {
        
        currentEditingModel = model
        
        let picker = screenFactory.createQuantityPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .pageSheet
        
        if let sheet = picker.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        rootViewController?.present(picker, animated: true)
    }
}

// MARK: - Quantity Picker Delegate

extension BagCoordinator: QuantitySelectionDelegate {
    public func didSelectQuantity(_ quantity: Double) {
        guard let model = currentEditingModel else { return }
        bagViewModel?.updateQuantity(for: model, count: quantity)
        currentEditingModel = nil
    }
}


//picker.onQuantitySelected = { [weak self] quantity in
//    self?.bagViewModel.updateQuantity(for: model, count: quantity)
//}


//public protocol Coordinatable {
//    func start() -> UIViewController
//}
//
//public protocol FactoryProtocol {
//    associatedtype ViewModel
//    associatedtype ViewController: UIViewController
//    func makeViewModel() -> ViewModel
//    func makeViewController(viewModel: ViewModel) -> ViewController
//}


//public final class GenericCoordinator<Factory: FactoryProtocol>: CoordinatorProtocol {
//    private let factory: Factory
//    public init(factory: Factory) { self.factory = factory }
//
//    public func start() -> UIViewController {
//        let vm = factory.makeViewModel()
//        let vc = factory.makeViewController(viewModel: vm)
//        return vc
//    }
//}

//typealias BagCoordinatorGeneric = GenericCoordinator<BagFactory>
