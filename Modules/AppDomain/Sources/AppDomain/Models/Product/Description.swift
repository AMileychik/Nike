//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct Description: Codable {
    public let description: String
    public let type: String
    
    public init(description: String, type: String) {
        self.description = description
        self.type = type
    }
}
