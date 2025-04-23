//
//  ShadowView.swift
//  Nike
//
//  Created by Александр Милейчик on 1/24/25.
//

import UIKit

class ShadowView: UIView {
    
    var isShadowEnabled: Bool = true {
        didSet {
            updateShadowVisibility()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureShadow(color: UIColor = .black,
                         opacity: Float = 0.4,
                         offset: CGSize = CGSize(width: 0, height: 2),
                         radius: CGFloat = 4) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    private func setupShadow() {
        backgroundColor = .white
        layer.cornerRadius = 8
        configureShadow()
        updateShadowVisibility()
    }
    
    private func updateShadowVisibility() {
        
        if isShadowEnabled {
            layer.shadowOpacity = 0.4
        } else {
            layer.shadowOpacity = 0
        }
    }
}
