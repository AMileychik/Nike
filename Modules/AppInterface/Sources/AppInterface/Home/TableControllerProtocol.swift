//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/21/25.
//

import UIKit

protocol TableControllerProtocol {
    var dataSource: UITableViewDataSource { get }
    var delegate: UITableViewDelegate? { get }
    func registerCells(in tableView: UITableView)
    func configure(tableView: UITableView)
}
