//
//  UITableViewCell + reuseId.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/23/24.
//

import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseId: String {
        
        return String.init(describing: self)
    }
}
