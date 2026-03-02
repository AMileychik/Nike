//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//

import UIKit

final class NewFromNikeCellBuilder: HomeCellBuilding {
    
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        guard case .newFromNike(let viewData) = section else { return UITableViewCell() }
        
        let cell: NewFromNikeCell = tableView.dequeueCell(indexPath)
        
        cell.update(viewData)
        
        cell.onAction = { action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        return cell
    }
}
