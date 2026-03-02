//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/21/25.
//

import UIKit
import AppDomain

// MARK: - WelcomeCellBuilder

/// Builder responsible for creating cells for the "Welcome" section on the Home screen.
final class WelcomeCellBuilder: HomeCellBuilding {
    
    // MARK: - HomeCellBuilding

    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        // Ensure the section is of the correct type
        guard case .welcome(let model) = section else { return UITableViewCell() }
        
        // Dequeue the cell
        let cell: WelcomeCell = tableView.dequeueCell(indexPath)
        
        // Configure the cell with the section data
        cell.configure(with: model)
        
        return cell
    }
}

