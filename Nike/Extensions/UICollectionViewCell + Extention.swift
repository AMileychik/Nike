//
//  UICollectionViewCell + Extention.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/22/24.
//

import UIKit

protocol ReusableCollectionViewCell {}

extension UICollectionViewCell: ReusableCollectionViewCell {}

extension ReusableCollectionViewCell where Self: UICollectionViewCell {
    
    static var reuseCVId: String {
        return String.init(describing: self)
    }
}
