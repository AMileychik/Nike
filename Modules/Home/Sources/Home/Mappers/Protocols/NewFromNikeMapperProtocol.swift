//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppDomain

public protocol NewFromNikeMapperProtocol {
    func map(_ model: NewFromNikeSectionModel) -> NewFromNikeSectionViewData
}
