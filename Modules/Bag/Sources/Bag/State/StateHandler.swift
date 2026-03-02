//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

//import UIKit
//
//public final class StateHandler: StateHandlerProtocol {
//    
//    private let output: BagViewModelOutput
//    public weak var bagScreen: BagViewDisplayingProtocol?
//    
//    public init(output: BagViewModelOutput, bagScreen: BagViewDisplayingProtocol) {
//        self.output = output
//        self.bagScreen = bagScreen
//    }
//    
//    public func bind() {
//        output.stateChanged = { [weak self] state in
//            DispatchQueue.main.async {
//                self?.handleStateChange(state)
//            }
//        }
//    }
//    
//    private func handleStateChange(_ state: BagViewModelState) {
//        switch state {
//            
//        case .initial, .loading:
//            break
//        case .loaded:
//            bagScreen?.reloadTable()
//
//        case .error(let error):
//            print("BagViewModel Error:", error)
//        }
//    }
//}


import Combine
import UIKit

public final class StateHandler: StateHandlerProtocol {

    private let output: BagViewModelOutput
    public weak var bagScreen: BagViewDisplayingProtocol?

    private var cancellables: Set<AnyCancellable> = []

    public init(output: BagViewModelOutput, bagScreen: BagViewDisplayingProtocol) {
        self.output = output
        self.bagScreen = bagScreen
    }

    public func bind() {

        output.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleStateChange(state)
            }
            .store(in: &cancellables)
    }

    private func handleStateChange(_ state: BagViewModelState) {
        switch state {
        case .initial, .loading:
            break

        case .loaded:
            bagScreen?.reloadTable()

        case .error(let error):
            print("BagViewModel Error: \(error)")
        }
    }
}
