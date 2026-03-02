//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit

public final class DetailUIComponentsFactory: DetailUIComponentsFactoryProtocol {
    
    public init() {}
    
    public func makeTableView(viewModel: DetailViewModelProtocol) -> (UIView & DetailTableViewProtocol) {
        DetailTableView(detailViewModel: viewModel)
    }
}
