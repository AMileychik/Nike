//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

// MARK: - Reusable Protocol

public protocol Reusable: AnyObject {
    static var reuseId: String { get }
}

// MARK: - Default Implementation

public extension Reusable {
    static var reuseId: String {
        String(describing: Self.self)
    }
}

// MARK: - Conformance

extension UITableViewCell: Reusable {}

