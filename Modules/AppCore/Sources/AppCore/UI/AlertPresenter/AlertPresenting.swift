//
//  File 2.swift
//  
//
//  Created by Александр Милейчик on 1/3/26.
//

import Foundation

public protocol AlertPresenting: AnyObject {
    func show(title: String, message: String)
}
