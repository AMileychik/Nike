//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation

import AppDomain

public struct WelcomeProvider: HomeSectionProviderProtocol {
    public let priority = HomeSectionPriority.welcome
    
    public init() {}

    public func makeSection(
        from response: HomeSectionsResponse
    ) -> HomeSectionModel? {
        
        let model = WelcomeSectionModel(title: Date().welcomeText)
       
        return HomeSectionModel(type: .welcome, data: .welcome(model))
    }
}
