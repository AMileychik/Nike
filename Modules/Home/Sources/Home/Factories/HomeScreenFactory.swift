//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit
import AppInterface
import SharedUI

public final class HomeScreenFactory: HomeScreenFactoryProtocol, ScreenFactoryProtocol {

    // MARK: - Dependencies
    
    private let uiComponentsFactory: HomeUIComponentsFactoryProtocol
    private let tableModuleFactory: HomeTableModuleFactoryProtocol

    // MARK: - Init
    
    public init(
        uiComponentsFactory: HomeUIComponentsFactoryProtocol,
        tableModuleFactory: HomeTableModuleFactoryProtocol
    ) {
        self.uiComponentsFactory = uiComponentsFactory
        self.tableModuleFactory = tableModuleFactory
    }

    // MARK: - HomeScreenFactoryProtocol
    
    /// Creates the Home screen with table content, refresh control, and activity indicator.
    public func createHomeScreen(
        viewModel: HomeViewModelProtocol
    ) -> UIViewController & HomeViewDisplayingProtocol {

        let contentView = tableModuleFactory.makeTableContainer(for: viewModel)

        let homeVC = HomeViewController(
            contentView: contentView,
            refreshControl: uiComponentsFactory.makeRefreshControl(),
            activityIndicator: uiComponentsFactory.makeActivityIndicator(style: .large, color: .black)
        )
        
        return homeVC
    }

    /// Creates a Coming Soon screen.
    public func createComingSoonScreen() -> ComingSoonViewController {
        ComingSoonViewController()
    }
}
