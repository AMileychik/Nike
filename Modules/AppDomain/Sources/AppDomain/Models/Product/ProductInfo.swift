//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ProductInfo: Codable {
    public let title: String?
    public let description: String?
    public let image: String?
    
    public init(title: String?, description: String?, image: String?) {
        self.title = title
        self.description = description
        self.image = image
    }
}
