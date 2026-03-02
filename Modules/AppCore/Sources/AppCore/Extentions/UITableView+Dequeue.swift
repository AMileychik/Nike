//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

public extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else {
            fatalError("❌ Failed to dequeue cell of type \(Cell.self) with reuseId \(Cell.reuseId) at \(indexPath)")
        }
        return cell
    }
    
//    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
//        
//        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
//        else { fatalError("Fatal error for cell at \(indexPath)") }
//        
//        return cell
//    }
    
//    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
//        if let cell = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell {
//            return cell
//        } else {
//            print("⚠️ Warning: Failed to dequeue cell \(Cell.reuseId) at \(indexPath). Returning default UITableViewCell.")
//            return UITableViewCell() as! Cell
//        }
//    }
}
