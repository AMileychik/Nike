//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 1/3/26.
//

import UIKit

public protocol AlertPresenting: AnyObject {
    func show(title: String, message: String)
    func attach(to viewController: UIViewController)
    func showError(message: String)
}
