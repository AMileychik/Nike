//
//  UIView + Extension.swift
//  LagomStore
//
//  Created by Александр Милейчик on 3/13/25.
//

import UIKit

extension UIView {
    static func makeSeparator(color: UIColor = UIColor(white: 0.9, alpha: 1), height: CGFloat = 1) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}

extension UIView {
    var viewController: UIViewController? {
        return sequence(first: self) { $0.next }
            .first(where: { $0 is UIViewController }) as? UIViewController
    }
}
