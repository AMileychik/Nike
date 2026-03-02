//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/21/25.
//

import UIKit

import AppDomain

final class WelcomeCellBuilder: HomeCellBuilding {
    
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        guard case .welcome(let model) = section else { return UITableViewCell() }
        
        let cell: WelcomeCell = tableView.dequeueCell(indexPath)
        
        cell.configure(with: model)
        
        return cell
    }
}
