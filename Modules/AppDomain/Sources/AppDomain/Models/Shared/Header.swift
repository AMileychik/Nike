//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct Header: Codable {
    public let title: String?
    public let subtitleLabel: String?
    public let buttonTitle: String?
    
    public init(
        title: String?,
        subtitleLabel: String?,
        buttonTitle: String?
    ) {
        self.title = title
        self.subtitleLabel = subtitleLabel
        self.buttonTitle = buttonTitle
    }
}
