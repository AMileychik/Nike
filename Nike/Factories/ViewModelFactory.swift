//
//  ViewModelFactory.swift
//  Nike
//
//  Created by Александр Милейчик on 5/29/25.
//

import Foundation

protocol ViewModelFactoryProtocol {
    func makeHomeViewModel() -> HomeViewModel
    func makeDetailViewModel() -> DetailViewModel
}

final class ViewModelFactory: ViewModelFactoryProtocol {
    
    // MARK: - Dependencies
    private let container: DependencyContainerProtocol
    
    // MARK: - Init
    init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    // MARK: - HomeViewModel
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(homeLoader: container.networkService)
    }
    
    // MARK: - DetailViewModel
    func makeDetailViewModel() -> DetailViewModel {
        DetailViewModel()
    }
}
