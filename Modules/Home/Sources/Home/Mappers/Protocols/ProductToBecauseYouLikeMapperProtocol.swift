//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppDomain

public protocol ProductToBecauseYouLikeMapperProtocol {
    func map(_ product: Product) -> AnyItemModel
    func mapToDomain(_ item: AnyItemProtocol) -> TopPickSelection
}
