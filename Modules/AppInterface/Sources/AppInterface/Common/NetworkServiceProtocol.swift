//
//  NetworkServiceProtocol.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import AppDomain

public protocol NetworkServiceProtocol {
    func loadHomeData(completion: @escaping (Result<HomeSectionsResponse, Error>) -> ())
    func loadShopData(completion: @escaping (Result<ShopSectionsResponse, Error>) -> ())
}
