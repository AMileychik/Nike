//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import UIKit

import AppDomain

public protocol HomeCoordinatorProtocol: AnyObject {
    func showDetail(data: DetailData)
    func showComingSoon()
}
