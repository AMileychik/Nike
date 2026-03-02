//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

public extension UIView {
    static func makeSeparator(color: UIColor = UIColor(white: 0.9, alpha: 1), height: CGFloat = 1) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}


