//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ProductSize: Codable {
    public let size: String?
    
    public init(size: String?) {
        self.size = size
    }
}
