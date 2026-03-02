//
//  DetailViewModel.swift
//  Nike
//
//  Created by Александр Милейчик on 6/1/25.
//

import UIKit
import AppCore
import AppDomain
import AppInterface

public final class DetailViewModel: DetailViewModelProtocol {
        
    public var detailSections: [DetailSection] = []
    public let useCase: DetailUseCaseProtocol
    public var selectedSubCategory: SubCategoryModel?
    
    public var stateChanged: ((DetailViewModelState) -> Void)?
    public var effectHandler: ((DetailEffect) -> Void)?
    
    public init(useCase: DetailUseCaseProtocol) {
        self.useCase = useCase
    }
}
