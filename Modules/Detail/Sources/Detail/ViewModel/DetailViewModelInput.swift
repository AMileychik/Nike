//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import Foundation
import AppDomain

extension DetailViewModel {
    
    public func loadData(_ data: DetailData) {
        stateChanged?(.loading)
        let uiModel = DetailMapper.map(data)
        //       self.detailSections = uiModel.sections
        stateChanged?(.loaded(uiModel))
    }
    
    public  func addToBag(_ categories: [SubCategoryModel]) {
        if let selected = selectedSubCategory {
            useCase.saveAndAddToBag([selected])
        } else if let first = categories.first {
            selectedSubCategory = first
            useCase.saveAndAddToBag([first])
        } else {
            print("No subCategories")
        }
    }
    
    public func addToFavorites(_ categories: [SubCategoryModel]) {
        if let selected = selectedSubCategory {
            useCase.saveAndAddToFavorite([selected])
        } else if let first = categories.first {
            selectedSubCategory = first
            useCase.saveAndAddToFavorite([first])
        } else {
            print("No subCategories")
        }
    }
    
    public func updateSelectedSubCategory(_ model: SubCategoryModel) {
        selectedSubCategory = model
    }
    
    public func didRequestAddToBag(with categories: [SubCategoryModel]) {
        addToBag(categories)
    }
    
    public func didRequestAddToFavorites(with categories: [SubCategoryModel]) {
        addToFavorites(categories)
    }
    
    public func sendEvent(_ action: DetailViewModelEvent) {
        switch action {
        case .completeTheLookDidTap:
            effectHandler?(.comingSoon)
        }
    }
}
