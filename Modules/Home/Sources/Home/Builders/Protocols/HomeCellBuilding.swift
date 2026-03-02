//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/20/25.
//

import UIKit
import AppInterface
import AppDomain

protocol HomeCellBuilding {
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?) -> UITableViewCell
}


