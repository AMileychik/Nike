//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct DetailButtonsModel: Codable {
    public let firstButtonTitle: String?
    public let secondButtonTitle: String?
    
    public init(
        firstButtonTitle: String?,
        secondButtonTitle: String?
    ) {
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
    }
}
