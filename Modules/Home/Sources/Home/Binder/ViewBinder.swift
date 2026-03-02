//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

public final class ViewBinder: ViewBinderProtocol {
    
    private let input: HomeViewModelInput
    private weak var viewController: HomeViewDisplayingProtocol?
    
    public init(input: HomeViewModelInput, viewController: HomeViewDisplayingProtocol) {
        self.input = input
        self.viewController = viewController
    }
    
    public func bind() {
        bindUserActions()
        input.onAppear()
    }
}

// MARK: - User Interaction
private extension ViewBinder {
    
    func bindUserActions() {
        guard let vc = viewController else { return }

        vc.refreshControl.addTarget(self, action: #selector(onRefreshTriggered), for: .valueChanged)
        vc.configureRefreshControl()
    }
    
    @objc func onRefreshTriggered() {
        input.loadProducts()
    }
    
    @objc public func onSearchButtonTapped() {
        input.sendEvent(.barButtonDidTap)
    }
}

