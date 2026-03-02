//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/10/25.
//

import UIKit

import AppDomain

public protocol HomeCellFactoryProtocol: AnyObject {
    func makeCell(
        tableView: UITableView,
        indexPath: IndexPath,
        section: HomeSectionModel,
        actionHandler: HomeCellActionHandlerProtocol
    ) -> UITableViewCell
}
