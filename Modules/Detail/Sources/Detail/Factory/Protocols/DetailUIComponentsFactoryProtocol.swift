//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit

public protocol DetailUIComponentsFactoryProtocol: AnyObject {
    func makeTableView(viewModel: DetailViewModelProtocol) -> (UIView & DetailTableViewProtocol)
}
