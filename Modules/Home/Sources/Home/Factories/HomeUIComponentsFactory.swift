//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit
import AppCore

//public final class HomeUIComponentsFactory: HomeUIComponentsFactoryProtocol {
//    
//    public init() {}
//    
//    public func makeRefreshControl() -> UIRefreshControl {
//        let refresh = UIRefreshControl()
//        refresh.tintColor = .gray
//        return refresh
//    }
//    
//    public func makeActivityIndicator(
//        style: UIActivityIndicatorView.Style = .large,
//        color: UIColor = .black
//    ) -> UIActivityIndicatorView {
//        
//        let indicator = UIActivityIndicatorView(style: style)
//        indicator.color = color
//        return indicator
//    }
//    
//    public func makeTableViewContainer(
//        controller: BaseTableControllerProtocol
//    ) -> HomeTableViewContainer {
//        
//        return HomeTableViewContainer(controller: controller)
//    }
//}

import UIKit
import AppCore
import DesignSystem

public final class HomeUIComponentsFactory: HomeUIComponentsFactoryProtocol {
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Public Factory Methods
    
    /// Creates a configured UIRefreshControl for Home screens
    public func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        return refreshControl
    }
    
    /// Creates a configured UIActivityIndicatorView
    public func makeActivityIndicator(
        style: UIActivityIndicatorView.Style = .large,
        color: UIColor = .black
    ) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }
    
    /// Wraps a BaseTableControllerProtocol in a HomeTableViewContainer
    public func makeTableViewContainer(
        controller: BaseTableControllerProtocol
    ) -> HomeTableViewContainer {
        HomeTableViewContainer(controller: controller)
    }
    
    public func makeHeaderButton() -> HeaderButtonProtocol {
        HeaderButton()
    }
}
