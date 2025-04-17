//
//  CustomButton.swift
//  LagomStore
//
//  Created by Александр Милейчик on 2/23/25.
//

import UIKit

final class CustomButton: UIView {
    
    var onButtonTapped: (() -> Void)?
    
    lazy var customButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(
        title: String? = nil,
        backgroundColor: UIColor? = nil,
        titleColor: UIColor? = nil,
        cornerRadius: CGFloat = 16,
        font: UIFont = UIFont.systemFont(ofSize: 17, weight: .bold),
        iconImage: UIImage? = nil,
        iconSize: CGSize = CGSize(width: 24, height: 24)
    ) {
        super.init(frame: .zero)
        
        customButton.setTitle(title, for: .normal)
        customButton.backgroundColor = backgroundColor
        customButton.setTitleColor(titleColor, for: .normal)
        customButton.titleLabel?.font = font
        customButton.layer.cornerRadius = cornerRadius
        customButton.layer.borderWidth = 1
        customButton.layer.borderColor = UIColor.black.cgColor
        customButton.clipsToBounds = true
        
        if let iconImage = iconImage, let title = title {
            let attachment = NSTextAttachment()
            attachment.image = iconImage
            attachment.bounds = CGRect(x: 0, y: -3, width: iconSize.width, height: iconSize.height) 
            
            let attachmentString = NSAttributedString(attachment: attachment)
            let textString = NSAttributedString(string: " \(title)", attributes: [
                .font: font
            ])
            
            let fullString = NSMutableAttributedString()
            fullString.append(attachmentString)
            fullString.append(textString)
            
            customButton.setAttributedTitle(fullString, for: .normal)
        }
        
        setupViews()
        setupConstraints()
        
        customButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(customButton)
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
