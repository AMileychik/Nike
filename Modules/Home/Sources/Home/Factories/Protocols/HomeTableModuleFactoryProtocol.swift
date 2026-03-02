//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

public protocol HomeTableModuleFactoryProtocol: AnyObject {
    func makeTableContainer(
        for viewModel: HomeViewModelProtocol
    ) -> HomeTableViewContainer
}
