//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/13/25.
//

import AppInterface
import Services

public final class BagViewModelFactory: BagViewModelFactoryProtocol, ViewModelFactoryProtocol {
    
    private let container: DependencyContainerProtocol
    
    public init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    public func makeBagViewModel() -> BagViewModelProtocol {
        let useCase = BagUseCase(bagService: container.bagService,
                                     favoriteService: container.favoriteService)
        return BagViewModel(useCase: useCase)
    }
}
