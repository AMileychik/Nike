//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/30/25.
//

import UIKit

public extension UIView {
    var viewController: UIViewController? {
        return sequence(first: self) { $0.next }
            .first(where: { $0 is UIViewController }) as? UIViewController
    }
}
