//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

public protocol BagButtonsViewProtocol: AnyObject {
    var onPayTapped: (() -> Void)? { get set }
    var onCheckoutTapped: (() -> Void)? { get set }
}
