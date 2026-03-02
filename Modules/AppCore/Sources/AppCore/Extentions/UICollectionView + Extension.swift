//
//  File.swift
//
//
//  Created by Александр Милейчик on 7/6/25.
//

import Foundation

import UIKit

public extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: Cell.reuseCVId)
    }
    
    func dequeuCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseCVId, for: indexPath) as? Cell else {
            fatalError("Fatal error for cell at \(indexPath)")
        }
        return cell
    }
}
