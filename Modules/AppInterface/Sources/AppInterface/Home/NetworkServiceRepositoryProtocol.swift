//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/13/25.
//

import AppDomain

public protocol NetworkServiceRepositoryProtocol {
    func loadHomeData() async throws -> HomeSectionsResponse
    func loadShopData() async throws -> ShopSectionsResponse
}
