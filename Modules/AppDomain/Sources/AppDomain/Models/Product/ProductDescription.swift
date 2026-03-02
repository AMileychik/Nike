//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ProductDescription: Codable {
    public let description: String?
    
    public init(description: String?) {
        self.description = description
    }
}
