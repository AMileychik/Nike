//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/13/25.
//

import AppDomain

public protocol NetworkServiceUseCaseProtocol {
    func execute() async throws -> HomeSectionsResponse
}
