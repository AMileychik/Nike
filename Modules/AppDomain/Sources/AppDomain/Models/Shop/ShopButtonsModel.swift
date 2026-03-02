//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ShopButtonsModel: Codable {
    public let firstButtonTitle: String
    public let secondButtonTitle: String
    public let thirdButtonTitle: String
    
    public init(
        firstButtonTitle: String,
        secondButtonTitle: String,
        thirdButtonTitle: String
    ) {
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
        self.thirdButtonTitle = thirdButtonTitle
    }
}
