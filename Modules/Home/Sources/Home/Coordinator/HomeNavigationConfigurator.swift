//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/26/25.
//

import Foundation

protocol NavigationConfiguring {
    func configure(for navigationController: UINavigationController)
}

struct HomeNavigationConfigurator: NavigationConfiguring {

    func configure(for navigationController: UINavigationController) {
        let navigationItem = navigationController.navigationBar.topItem
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem?.title = "Home"
        navigationItem?.rightBarButtonItem = makeBagButton()
    }

    private func makeBagButton() -> UIBarButtonItem {
        UIBarButtonItem(
            image: UIImage(systemName: "bag"),
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
