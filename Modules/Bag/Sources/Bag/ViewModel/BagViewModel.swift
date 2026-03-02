//
//  BagViewModel.swift
//
//
//  Created by Александр Милейчик on 6/19/25.
//

import Services
import Bag
import AppInterface

public final class BagViewModel: BagViewModelProtocol {
    
    public var bagSections: [BagSections] = []
    public let useCase: BagUseCaseProtocol
    
    public var stateChanged: ((BagViewModelState) -> Void)?
    public var effectHandler: ((BagEffect) -> Void)?
    
    public init(useCase: BagUseCaseProtocol) {
        self.useCase = useCase
    }
}

