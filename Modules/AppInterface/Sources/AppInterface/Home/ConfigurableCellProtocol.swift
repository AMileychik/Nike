//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/16/25.
//

import AppDomain

//public protocol ConfigurableCellProtocol: AnyObject {
//    var onAction: ((HomeCellAction) -> Void)? { get set }
//    func configure(with model: HomeSections)
//}

public protocol ConfigurableCellProtocol: AnyObject {
//    func configure(with model: HomeSections)
    func configure(with text: String)

}

//public protocol ConfigurableCellProtocol {
//    associatedtype Model
//    func configure(with model: Model)
//}
//
//// Do I need this protocol??? and associatedtype Model?
//public protocol ActionableCellProtocol {
//    var onAction: ((HomeCellAction) -> Void)? { get set }
//}
