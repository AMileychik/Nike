//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

import AppDomain
import AppInterface

public protocol WelcomeSectionMapperProtocol {
    func map(_ model: WelcomeSectionModel) -> WelcomeViewData
}

public final class WelcomeSectionMapper: WelcomeSectionMapperProtocol {
    public init() {}

    public func map(_ model: WelcomeSectionModel) -> WelcomeViewData {
        WelcomeViewData(text: model.title)
    }
}
