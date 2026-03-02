//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/21/25.
//

import UIKit

public protocol HomeTableViewManagerProtocol: UITableViewDelegate {
    func registerCells(for tableView: UITableView)
}
