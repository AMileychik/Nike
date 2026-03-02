//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/3/25.
//

import AppDomain

public protocol ViewBinderProtocol: AnyObject {
    func update(with data: DetailData)
}
