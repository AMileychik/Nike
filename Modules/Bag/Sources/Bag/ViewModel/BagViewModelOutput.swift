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
        
    public func numberOfSections() -> Int {
        bagSections.count
    }
    
    public func section(at index: Int) -> BagSections? {
        guard index >= 0 && index < bagSections.count else { return nil }
        return bagSections[index]
    }
    
    public func indexForSection(_ sectionType: BagSectionType) -> Int? {
        bagSections.firstIndex { $0.type == sectionType }
    }
    
    public func indexOfProduct(_ model: BagProductUIModel) -> Int? {
        guard let section = bagSections.first(where: { $0.type == .products }) else { return nil }
        switch section {
        case .products(let models):
            return models.firstIndex { $0.id == model.id }
        default:
            return nil
        }
    }
}
