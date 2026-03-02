//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct YouMightAlsoLikeModel: Codable {
    public let image: String
    
    public init(image: String) {
        self.image = image
    }
}

