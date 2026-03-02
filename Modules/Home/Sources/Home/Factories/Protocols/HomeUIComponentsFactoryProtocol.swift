//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

import AppCore
import DesignSystem

public protocol HomeUIComponentsFactoryProtocol {
    func makeRefreshControl() -> UIRefreshControl
    func makeActivityIndicator(style: UIActivityIndicatorView.Style, color: UIColor) -> UIActivityIndicatorView
    func makeHeaderButton() -> HeaderButtonProtocol
    func makeAlertPresenter() -> AlertPresenting
}
