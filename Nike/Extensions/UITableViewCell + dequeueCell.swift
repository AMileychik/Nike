//
//  UITableViewCell + dequeueCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/23/24.
//

import UIKit

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
        else { fatalError("Fatal error for cell at \(indexPath)") }
        
        return cell
    }
}
