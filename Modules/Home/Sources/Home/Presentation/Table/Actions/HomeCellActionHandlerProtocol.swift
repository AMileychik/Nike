//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/16/25.
//

import UIKit

import AppDomain

public protocol HomeCellActionHandlerProtocol: AnyObject {
    func handle(_ action: HomeCellAction, at indexPath: IndexPath)
}
