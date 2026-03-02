//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

import AppCore
import DesignSystem

// MARK: - HomeUIComponentsFactory
///
/// Central point for creating and configuring all UI components for the Home feature.
/// Provides a single source of truth for UI dependencies, ensuring consistency and reducing duplication.
/// Improves testability.

public final class HomeUIComponentsFactory: HomeUIComponentsFactoryProtocol {
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Public Factory Methods
    
    /// Creates a configured pull-to-refresh control for Home screens
    public func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        return refreshControl
    }
    
    /// Creates a configured activity indicator for global loading state
    public func makeActivityIndicator(
        style: UIActivityIndicatorView.Style = .large,
        color: UIColor = .black
    ) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }
    
    /// Creates a header button for the Home screen
    public func makeHeaderButton() -> HeaderButtonProtocol {
        HeaderButton()
    }
    
    /// Creates a reusable alert presenter
    public func makeAlertPresenter() -> AlertPresenting {
        AlertPresenter()
    }
}
