//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/15/25.
//

import UIKit

import AppInterface
import SharedUI

// MARK: - HomeScreenFactory
///
/// Central factory for building Home screens and related UI.
/// Provides a single point for creating HomeViewController with all dependencies wired up,
/// including table content, refresh control, activity indicator, and alert handling.

public final class HomeScreenFactory: HomeScreenFactoryProtocol, ScreenFactoryProtocol {

    // MARK: - Dependencies
    
    private let uiComponentsFactory: HomeUIComponentsFactoryProtocol
    private let tableModuleFactory: HomeTableModuleFactoryProtocol

    // MARK: - Initialization
    
    public init(
        uiComponentsFactory: HomeUIComponentsFactoryProtocol,
        tableModuleFactory: HomeTableModuleFactoryProtocol
    ) {
        self.uiComponentsFactory = uiComponentsFactory
        self.tableModuleFactory = tableModuleFactory
    }

    // MARK: - Public Factory Methods
    
    /// Creates a fully configured Home screen.
    public func createHomeScreen(viewModel: HomeViewModelProtocol) -> UIViewController & HomeViewDisplayingProtocol {

        // Create the table content for Home
        let contentView = tableModuleFactory.makeTableContainer(for: viewModel)
        
        // Create AlertPresenter first (without attaching to VC yet)
        let alertPresenter = uiComponentsFactory.makeAlertPresenter()
        
        // Create HomeViewController with injected dependencies
        let homeVC = HomeViewController(
            contentView: contentView,
            refreshControl: uiComponentsFactory.makeRefreshControl(),
            activityIndicator: uiComponentsFactory.makeActivityIndicator(style: .large, color: .black),
            alertPresenter: alertPresenter
        )
        
        // Attach the VC to the AlertPresenter to allow presenting alerts
        alertPresenter.attach(to: homeVC)
        
        return homeVC
    }

    /// Creates a Coming Soon screen.
    public func createComingSoonScreen() -> ComingSoonViewController {
        ComingSoonViewController()
    }
}
