//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/31/25.
//

import UIKit
import DesignSystem
import AppInterface
import SharedUI

public final class DetailScreenFactory: DetailScreenFactoryProtocol, ScreenFactoryProtocol {
    
//    public let viewModelFactory: DetailViewModelFactoryProtocol
    private let uiComponentsFactory: DetailUIComponentsFactoryProtocol
    
    public init(
//        viewModelFactory: DetailViewModelFactoryProtocol,
                uiComponentsFactory: DetailUIComponentsFactoryProtocol)
    {
//        self.viewModelFactory = viewModelFactory
        self.uiComponentsFactory = uiComponentsFactory
    }
    
    public func createDetailScreen(viewModel: DetailViewModelProtocol) -> DetailViewController  {
        let tableView = uiComponentsFactory.makeTableView(viewModel: viewModel)
    //    let viewModel = viewModelFactory.makeDetailViewModel()
       
        return DetailViewController(tableView: tableView, viewModel: viewModel)
    }
    
    public func createComingSoonScreen() -> UIViewController {
        return ComingSoonViewController()
    }
}
