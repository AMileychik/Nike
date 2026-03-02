//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/22/25.
//

import UIKit
import AppDomain

// MARK: - ThankYouCellBuilder

/// Builder responsible for creating cells for the "Thank You" section on the Home screen.
final class ThankYouCellBuilder: HomeCellBuilding {
    
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        // Ensure the section is of the correct type
        guard case .thankYou(let model) = section else { return UITableViewCell() }
        
        // Dequeue the cell
        let cell: ThankYouCell = tableView.dequeueCell(indexPath)
        
        // Configure the cell with the section data
        cell.configure(with: model)
        
        return cell
    }
}

