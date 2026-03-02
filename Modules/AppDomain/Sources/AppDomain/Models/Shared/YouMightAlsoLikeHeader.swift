//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct YouMightAlsoLikeHeader: Codable {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}
