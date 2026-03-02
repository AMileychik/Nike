//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/22/25.
//

import UIKit
import AppDomain

final class ThankYouCellBuilder: HomeCellBuilding {
    
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        guard case .thankYou(let model) = section else { return UITableViewCell() }
        
        let cell: ThankYouCell = tableView.dequeueCell(indexPath)
        
        cell.configure(with: model)
        
        return cell
    }
}
