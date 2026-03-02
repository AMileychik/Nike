//
//  HeaderButton.swift
//  Nike
//
//  Created by Александр Милейчик on 2/28/25.
//

import UIKit

public protocol HeaderButtonProtocol: UIView {
    var onButtonTapped: (() -> Void)? { get set }
    func setTitle(_ title: String?)
}

//public final class HeaderButton: UIView, HeaderButtonProtocol {
//        
//    public lazy var customButton: UIButton = {
//        var button = UIButton(type: .system)
//        button.backgroundColor = .white
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        button.setTitleColor(UIColor(white: 0.4, alpha: 1), for: .normal)
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        return button
//    }()
//    
//    public var onButtonTapped: (()->())?
//    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        self.addSubview(customButton)
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            customButton.topAnchor.constraint(equalTo: topAnchor),
//            customButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            customButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//            customButton.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//    
//    public func setTitle(_ title: String?) {
//        customButton.setTitle(title, for: .normal)
//    }
//    
//    @objc private func buttonTapped(_ sender: UIButton) {
//        onButtonTapped?()
//    }
//}

public final class HeaderButton: UIView, HeaderButtonProtocol {
    
    public var onButtonTapped: (() -> Void)?

    public var title: String? {
        didSet { customButton.setTitle(title, for: .normal) }
    }

    public lazy var customButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 36)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(customButton)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: topAnchor),
            customButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            customButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            customButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }
    
    public func setTitle(_ title: String?) {
        customButton.setTitle(title, for: .normal)
    }
    
    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}
