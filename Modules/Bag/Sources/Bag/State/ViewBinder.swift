//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//


import DesignSystem

public final class ViewBinder: ViewBinderProtocol {
   
    private let actions: BagButtonsViewProtocol
    private let input: BagViewModelInput

    public init(input: BagViewModelInput, actions: BagButtonsViewProtocol) {
        self.input = input
        self.actions = actions
    }

    public func bind() {
        actions.onPayTapped = { [weak self] in 
            self?.input.sendEvent(.bagDidTap) }
        
        actions.onCheckoutTapped = { [weak self] in 
            self?.input.sendEvent(.bagDidTap) }
    }
}
