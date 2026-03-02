//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import Services
import Bag
import AppInterface

extension BagViewModel {
        
    public func updateSections() {
        stateChanged?(.loading)
        let domainModels = useCase.fetchBagItems()
        let uiModels = domainModels.map { BagMapper.mapToUIModel(from: $0) }
        let totalPrice = useCase.calculateTotalPrice()
        
        bagSections = BagSectionBuilder.createBagSections(from: uiModels, totalPrice: totalPrice)
        stateChanged?(.loaded)
    }
    
    public func deleteProduct(_ model: BagProductUIModel) {
        let domainModel = BagMapper.mapToDomainModel(from: model)
        useCase.deleteItem(domainModel)
        updateSections()
    }
    
    public func saveAndAddProduct(_ model: BagProductUIModel) {
        let domainModel = BagMapper.mapToDomainModel(from: model)
        useCase.saveFavorite(domainModel)
    }
    
    public func updateQuantity(for model: BagProductUIModel, count: Double) {
        var updatedModel = BagMapper.mapToDomainModel(from: model)
        updatedModel.count = count
        useCase.updateItem(updatedModel)
        updateSections()
    }
    
    public func sendEvent(_ action: BagViewModelEvent) {
        switch action {
        
        case .bagDidTap:
            effectHandler?(.presentComingSoon)
        
        case .quantityPickerDidTap(let model):
            effectHandler?(.showQuantityPicker(model))
        }
    }
}
