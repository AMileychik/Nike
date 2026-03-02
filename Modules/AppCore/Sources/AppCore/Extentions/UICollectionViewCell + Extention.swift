//
//  File.swift
//
//
//  Created by Александр Милейчик on 7/6/25.
//

 import UIKit

public protocol ReusableCollectionViewCell {}

extension UICollectionViewCell: ReusableCollectionViewCell {}

public extension ReusableCollectionViewCell where Self: UICollectionViewCell {
    
    static var reuseCVId: String {
        String(describing: self)
    }
}
