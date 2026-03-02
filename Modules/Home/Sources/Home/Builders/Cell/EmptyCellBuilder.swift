//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import UIKit

import AppDomain

final class EmptyCellBuilder: HomeCellBuilding {
   
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.isHidden = true
        cell.isUserInteractionEnabled = false
        return cell
    }
}
