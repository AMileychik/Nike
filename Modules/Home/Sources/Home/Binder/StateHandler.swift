//
//  File.swift
//
//
//  Created by Александр Милейчик on 11/9/25.
//

import Combine

public final class StateHandler: StateHandlerProtocol {
    
    private let output: HomeViewModelOutput
    public weak var homeScreen: HomeViewDisplayingProtocol?
    private var cancellables: Set<AnyCancellable> = []
    
    public init(output: HomeViewModelOutput, homeScreen: HomeViewDisplayingProtocol) {
        self.output = output
        self.homeScreen = homeScreen
    }
    
    public func bind() {
        output.statePublisher
            .sink { [weak self] state in
                self?.handleStateChange(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleStateChange(_ state: HomeViewModelState) {
        switch state {
            
        case .initial: break
            
        case .loading:
            homeScreen?.showLoading()
            
        case .loaded:
            homeScreen?.hideLoading()
            homeScreen?.stopRefreshing()
            homeScreen?.reloadContent()
            
        case .error(let error):
            homeScreen?.hideLoading()
            homeScreen?.stopRefreshing()
            
            if error.hasMessage {
                homeScreen?.showError(message: error.message)
            }
        }
    }
}
