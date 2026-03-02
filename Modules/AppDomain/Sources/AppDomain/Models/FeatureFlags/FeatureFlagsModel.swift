//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/5/25.
//

import Foundation

public struct FeatureFlagsModel: Codable {
    public let isBagEnabled: Bool
    public let isHomeEnabled: Bool
    
    public init(isBagEnabled: Bool, isHomeEnabled: Bool) {
        self.isBagEnabled = isBagEnabled
        self.isHomeEnabled = isHomeEnabled
    }
}
