//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

//import AppDomain
//import AppInterface

//public final class NetvorkServiceUseCase: HomeUseCaseProtocol {
//
//    private let repository: NetworkServiceRepositoryProtocol
//
//    public init(repository: NetworkServiceRepositoryProtocol) {
//        self.repository = repository
//    }
//
//    public func execute(
//        completion: @escaping (Result<HomeSectionsResponse, Error>) -> Void
//    ) {
//        repository.loadHomeData { result in
//            completion(result)
//        }
//    }
//}


//public final class NetvorkServiceUseCase: NetvorkServiceUseCaseProtocol {
//
//    private let repository: NetworkServiceRepositoryProtocol
//
//    public init(repository: NetworkServiceRepositoryProtocol) {
//        self.repository = repository
//    }
//
//    public func execute() async throws -> HomeSectionsResponse {
//        try await repository.loadHomeData()
//    }
//}


import Foundation
import AppDomain
import AppInterface

@available(iOS 15.0, *)
public final class NetworkServiceUseCase: NetvorkServiceUseCaseProtocol {

    private let repository: NetworkServiceRepositoryProtocol

    public init(repository: NetworkServiceRepositoryProtocol) {
        self.repository = repository
    }

    @available(iOS 15.0, *)
    public func execute() async throws -> HomeSectionsResponse {
        try await repository.loadHomeData()
    }
}
