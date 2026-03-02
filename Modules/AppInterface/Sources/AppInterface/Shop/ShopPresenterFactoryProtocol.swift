//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import Foundation

public protocol ShopPresenterFactoryProtocol {
    func makeShopPresenter() -> ShopPresenterProtocol
}
