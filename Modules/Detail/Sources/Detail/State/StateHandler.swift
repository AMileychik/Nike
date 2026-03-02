//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/3/25.
//

//import UIKit
//
//public final class StateHandler: StateHandlerProtocol {
//    
//    private let output: DetailViewModelOutput    
//    public weak var detailScreen: DetailDisplayingProtocol?
//    var tableView: DetailTableView?
//
//    public init(output: DetailViewModelOutput, detailScreen: DetailDisplayingProtocol?) {
//        self.output = output
//        self.detailScreen = detailScreen
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
//    private func handleStateChange(_ state: DetailViewModelState) {
//        switch state {
//        case .initial:
//            break
//
//        case .loading:
//            break
// //           showLoading()
//
//        case .loaded(let uiModel):
//            detailScreen?.updateSections(uiModel.sections)
//            detailScreen?.reloadTable()
//            
//        case .error(let message):
//            break
// //           showError(message)
//            
////            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
////            alert.addAction(UIAlertAction(title: "OK", style: .default))
////            present(alert, animated: true)
//        }
//    }
//}


// MARK: - StateHandler
import Combine
import UIKit

public final class StateHandler: StateHandlerProtocol {
    
    private let output: DetailViewModelProtocol
    public weak var detailScreen: DetailDisplayingProtocol?
    private var cancellables: Set<AnyCancellable> = []
    
    public init(output: DetailViewModelProtocol, detailScreen: DetailDisplayingProtocol?) {
        self.output = output
        self.detailScreen = detailScreen
    }
    
    public func bind() {
        output.statePublisher
            .sink { [weak self] state in
                self?.handleStateChange(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleStateChange(_ state: DetailViewModelState) {
        switch state {
        case .initial, .loading:
            break
        case .loaded(let uiModel):
            detailScreen?.updateSections(uiModel.sections)
            detailScreen?.reloadTable()
        case .error(let message):
            print("Error:", message)
        }
    }
}


