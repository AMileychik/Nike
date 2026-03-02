//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/2/25.
//

import Foundation

public protocol FeatureToggleServiceProtocol: AnyObject {
    
//    var isShopFeatureEnabled: Bool { get }
    var isBagFeatureEnabled: Bool { get }
    var isHomeFeatureEnabled: Bool { get }

    var onFlagsChanged: (() -> Void)? { get set }

    func updateFlags(
//        isShopFeatureEnabled: Bool?
        isBagFeatureEnabled: Bool?,
        isHomeFeatureEnabled: Bool?
    )
}
