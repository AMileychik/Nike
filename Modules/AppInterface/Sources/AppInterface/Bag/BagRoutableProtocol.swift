//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation

//public protocol BagRoutableProtocol: AnyObject {
//    var bagRouter: BagCoordinatorProtocol? { get set }
//}

public protocol BagRoutableProtocol: AnyObject {
    func payButtonTapped()
    func checkoutButtonTapped()
}
