//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

public protocol HomeViewDisplayingProtocol: AnyObject {
    
    var refreshControl: UIRefreshControl { get }
    
    func configureRefreshControl()
    func reloadContent()
    
    func showLoading()
    func hideLoading()
    func stopRefreshing()
    
    func showError(message: String)
}
