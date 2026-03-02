//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import UIKit

public final class BagButtonsView: UIView, BagButtonsViewProtocol {
    
    private var buttons: [BagButtonType: CustomButton] = [:]
    private let separatorView = UIView.makeSeparator()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
// MARK: - Implement Combine
    public var onPayTapped: (() -> Void)?
    public var onCheckoutTapped: (() -> Void)?
    
    
    public init(types: [BagButtonType] = [.pay, .checkout]) {
        super.init(frame: .zero)
        setupViews(with: types)
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Action Handler

extension BagButtonsView {
   
    private func setupActions() {
        buttons[.pay]?.onButtonTapped = { [weak self] in
            self?.onPayTapped?()
        }
        buttons[.checkout]?.onButtonTapped = { [weak self] in
            self?.onCheckoutTapped?()
        }
    }
}

// MARK: - Layout

extension BagButtonsView {
    
    private func setupViews(with types: [BagButtonType]) {
        backgroundColor = .systemBackground
        addSubview(separatorView)
        addSubview(buttonStackView)
        
        for type in types {
            let button = CustomButton(config: type.config)
            buttonStackView.addArrangedSubview(button)
            buttons[type] = button
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            buttonStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 24),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
}



