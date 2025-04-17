//
//  ButtonContainerView.swift
//  LagomStore
//
//  Created by Александр Милейчик on 2/16/25.
//

import UIKit

class ButtonContainerView: UIView {
    
    private let button: UIButton
    private let separator: UIView
    
    init(title: String, showSeparator: Bool) {
        self.button = UIButton(type: .system)
        self.separator = UIView()
        
        super.init(frame: .zero)
        
        backgroundColor = .clear 
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray.adjustBrightness(by: 0.250)
        
        separator.backgroundColor = .gray
        separator.isHidden = !showSeparator
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubview(separator)
        addSubview(button)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0),
            
            separator.widthAnchor.constraint(equalToConstant: 1),
            separator.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            separator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalTo: heightAnchor, constant: 10),
            button.widthAnchor.constraint(equalTo: widthAnchor, constant: -5)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        print("Button \(button.currentTitle ?? "") tapped")
    }
    
}
