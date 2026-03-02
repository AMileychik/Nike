//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/13/25.
//

import UIKit

public protocol BagTableViewProtocol: AnyObject {
    var delegate: UITableViewDelegate? { get set }
    var dataSource: UITableViewDataSource? { get set }
    
    func reloadData()
    func scrollToTop(animated: Bool)
}
