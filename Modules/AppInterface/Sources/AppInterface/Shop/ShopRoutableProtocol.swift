//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

import Foundation

public protocol ShopRoutableProtocol: AnyObject {
    var shopRouter: ShopCoordinatorProtocol? { get set }
}
