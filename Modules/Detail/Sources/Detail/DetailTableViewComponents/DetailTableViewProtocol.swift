//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit

public protocol DetailTableViewProtocol: AnyObject {
    var delegate: UITableViewDelegate? { get set }
    var dataSource: UITableViewDataSource? { get set }
    
    func reloadData()
    func scrollToTop(animated: Bool)
}
