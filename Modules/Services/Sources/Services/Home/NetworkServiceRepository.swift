//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

//import Foundation
//import AppDomain
//import AppInterface
//
//public final class NetworkServiceRepository: NetworkServiceRepositoryProtocol {
//
//    private let service: NetworkServiceProtocol
//
//    public init(service: NetworkServiceProtocol) {
//        self.service = service
//    }
//
//    public func loadHomeData(completion: @escaping (Result<HomeSectionsResponse, Error>) -> ()) {
//        service.loadHomeData(completion: completion)
//    }
//
//    public func loadShopData(completion: @escaping (Result<ShopSectionsResponse, Error>) -> ()) {
//        service.loadShopData(completion: completion)
//    }
//}

import Foundation
import AppDomain
import AppInterface



public final class NetworkServiceRepository: NetworkServiceRepositoryProtocol {

    private let service: NetworkServiceProtocol

    public init(service: NetworkServiceProtocol) {
        self.service = service
    }

    public func loadHomeData() async throws -> HomeSectionsResponse {
        try await service.loadHomeData()
    }

    public func loadShopData() async throws -> ShopSectionsResponse {
        try await service.loadShopData()
    }
}
