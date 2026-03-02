//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import Foundation

public protocol HomeBinderFactoryProtocol {
    func makeBinder(
        viewModel: HomeViewModelProtocol,
        viewController: HomeViewDisplayingProtocol,
        router: HomeCoordinatorProtocol
    ) -> HomeBinderProtocol
}
