//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

import UIKit

public final class StateHandler: StateHandlerProtocol {
    
    private let output: BagViewModelOutput
    public weak var bagScreen: BagViewDisplayingProtocol?
    
    public init(output: BagViewModelOutput, bagScreen: BagViewDisplayingProtocol) {
        self.output = output
        self.bagScreen = bagScreen
    }
    
    public func bind() {
        output.stateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.handleStateChange(state)
            }
        }
    }
    
    private func handleStateChange(_ state: BagViewModelState) {
        switch state {
            
        case .initial, .loading:
            break
        case .loaded:
            bagScreen?.reloadTable()

        case .error(let error):
            print("BagViewModel Error:", error)
        }
    }
}
