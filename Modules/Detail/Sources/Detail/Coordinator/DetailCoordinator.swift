//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit
import AppDomain

public class DetailCoordinator: DetailCoordinatorProtocol {
    
    public let viewModelFactory: DetailViewModelFactoryProtocol
    public let screenFactory: DetailScreenFactoryProtocol
   // public var detailViewModel: DetailViewModelProtocol?
    public var binder: DetailBinderProtocol?
    
    public let navigationController: UINavigationController

    private weak var rootViewController: UIViewController?
    
    public init(viewModelFactory: DetailViewModelFactoryProtocol,
                screenFactory: DetailScreenFactoryProtocol,
                navigationController: UINavigationController)
    {
        self.viewModelFactory = viewModelFactory
        self.screenFactory = screenFactory
        self.navigationController = navigationController
    }
    
    public func start(with data: DetailData) -> UIViewController {
        let detailViewModel = viewModelFactory.makeDetailViewModel()
        let detailVC = screenFactory.createDetailScreen(viewModel: detailViewModel)

 //       self.detailViewModel = detailViewModel
        
        let viewBinder = ViewBinder(input: detailViewModel)
        let stateHandler = StateHandler(output: detailViewModel, detailScreen: detailVC)
        let effectHandler = EffectHandler(output: detailViewModel, router: self)

        let detailBinder = DetailBinder(
            viewBinder: viewBinder,
            stateHandler: stateHandler,
            effectHandler: effectHandler
        )
        self.binder = detailBinder
        
        stateHandler.bind()
        effectHandler.bind()
        viewBinder.update(with: data)
        
        rootViewController = detailVC
        return detailVC
    }
    
    public func navigateToCommingSoonViewController() {
//        let viewController = screenFactory.createComingSoonScreen()
//        navigationController.pushViewController(viewController, animated: true)
        
        let vc = screenFactory.createComingSoonScreen()
        vc.modalPresentationStyle = .fullScreen
        rootViewController?.present(vc, animated: true)
    }
}


