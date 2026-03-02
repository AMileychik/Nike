//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/15/25.
//

import Foundation

import AppDomain

public protocol HomeSectionProviderProtocol {
    var priority: Int { get }
    func makeSection(from response: HomeSectionsResponse) -> HomeSectionModel?
}
