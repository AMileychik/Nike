//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/1/25.
//

import Foundation
import AppInterface
import Services

public final class DetailViewModelFactory: DetailViewModelFactoryProtocol {
    
    public let container: DependencyContainerProtocol
    
    public init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    public func makeDetailViewModel() -> DetailViewModelProtocol {
        let useCase = DetailUseCase(bagService: container.bagService, favoriteService: container.favoriteService)
        
        return DetailViewModel(useCase: useCase)
    }
}
