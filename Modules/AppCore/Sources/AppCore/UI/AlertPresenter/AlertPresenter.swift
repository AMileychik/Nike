//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/3/26.
//

import UIKit

public final class AlertPresenter: AlertPresenting {
    weak var viewController: UIViewController?

    public init() {}
    
    public func attach(to viewController: UIViewController) {
        self.viewController = viewController
    }

    public func show(title: String, message: String) {
        guard let vc = viewController,
              vc.presentedViewController == nil else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
    
    public func showError(message: String) {
        show(title: "Error", message: message)
    }
}
