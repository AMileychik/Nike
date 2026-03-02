//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

public protocol HomeErrorMapping {
    func map(_ error: Error) -> HomeError
}
