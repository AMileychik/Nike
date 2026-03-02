//
//  HeaderButton.swift
//  Nike
//
//  Created by Александр Милейчик on 2/28/25.
//

import UIKit

public final class HeaderButton: UIView {
    
    public lazy var customButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(white: 0.4, alpha: 1), for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    public var onButtonTapped: (()->())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(customButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: topAnchor),
            customButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            customButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            customButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        onButtonTapped?()
    }
}
