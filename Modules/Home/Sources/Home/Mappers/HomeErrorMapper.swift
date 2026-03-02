//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/24/25.
//

import Foundation

public protocol HomeErrorMapping {
    func map(_ error: Error) -> HomeError
}

public struct HomeErrorMapper: HomeErrorMapping {
    public func map(_ error: Error) -> HomeError {
        switch error {
        case is URLError:
            return .network
        default:
            return .unknown
        }
    }
}
