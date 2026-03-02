//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/3/26.
//

import Foundation

final class AlertPresenter: AlertPresenting {

    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func showAlert(title: String, message: String) {
        guard let vc = viewController,
              vc.presentedViewController == nil else { return }

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}
