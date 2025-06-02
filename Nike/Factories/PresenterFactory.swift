//
//  ShopPresenterFactory.swift
//  Nike
//
//  Created by Александр Милейчик on 5/31/25.
//

import Foundation

protocol ShopPresenterFactoryProtocol {
    func makeShopPresenter() -> ShopPresenterProtocol
}

final class ShopPresenterFactory: ShopPresenterFactoryProtocol {
    
    private let container: DependencyContainerProtocol
    
    init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    func makeShopPresenter() -> ShopPresenterProtocol {
        ShopPresenter(shopLoader: container.networkService)
    }
}
