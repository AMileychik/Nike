//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit

public protocol DetailCellFactoryProtocol {
    func makeCell(for section: DetailSection, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
