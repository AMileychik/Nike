//
//  UICollectionView + Extension.swift
//  Nike
//
//  Created by Александр Милейчик on 10/22/24.
//

import UIKit

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseCVId)
    }
    
    func dequeuCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseCVId, for: indexPath) as? Cell
        else { fatalError("Fatal error for cell at \(indexPath)") }
        
        return cell
    }
}
