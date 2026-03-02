//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

public protocol HomeBinderProtocol: AnyObject {
    var viewBinder: ViewBinderProtocol { get }
    func bind()
}
