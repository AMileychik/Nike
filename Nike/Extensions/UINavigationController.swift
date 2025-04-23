//
//  UINavigationController.swift
//  Nike
//
//  Created by Александр Милейчик on 3/4/25.
//

import UIKit

extension UINavigationController {
    
    func setupNavigationBar(
        prefersLargeTitles: Bool = true,
        titleFont: UIFont = UIFont.systemFont(ofSize: 25, weight: .medium),
        titleColor: UIColor = UIColor(white: 0.1, alpha: 1),
        layoutMarginLeft: CGFloat = 24,
        barTintColor: UIColor? = nil
    ) {
        let navigationBar = self.navigationBar
        
        navigationBar.prefersLargeTitles = prefersLargeTitles

        navigationBar.largeTitleTextAttributes = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        
        navigationBar.layoutMargins.left = layoutMarginLeft
        if let barTintColor = barTintColor {
            navigationBar.barTintColor = barTintColor
        }
    }
    
    func addMagnifyButton(target: Any?, action: Selector, title: String? = nil, buttonTintColor: UIColor = .black) {
        if let title = title {
            let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
            barButtonItem.tintColor = buttonTintColor
            self.topViewController?.navigationItem.rightBarButtonItem = barButtonItem
        } else {
            let magnifyButton = UIButton(type: .system)
            magnifyButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            magnifyButton.tintColor = buttonTintColor
            magnifyButton.addTarget(target, action: action, for: .touchUpInside)
            
            let barButtonItem = UIBarButtonItem(customView: magnifyButton)
            barButtonItem.style = .plain
            self.topViewController?.navigationItem.rightBarButtonItem = barButtonItem
        }
    }
}

