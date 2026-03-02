//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit

// MARK: - HomeTableViewContainerProtocol
///
/// Defines the public API for table containers used in Home feature.
public protocol HomeTableViewContainerProtocol: AnyObject {
    
    /// The pull-to-refresh control for the table
    var refreshControl: UIRefreshControl? { get set }
    
    /// Reloads the table content
    func reloadData()
    
    /// Scrolls the table to the top
    func scrollToTop(animated: Bool)
}
