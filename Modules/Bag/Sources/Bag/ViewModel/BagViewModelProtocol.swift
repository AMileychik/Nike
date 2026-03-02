//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

public protocol BagViewModelInput: AnyObject {
    func updateSections()
    func deleteProduct(_ model: BagProductUIModel)
    func saveAndAddProduct(_ model: BagProductUIModel)
    func updateQuantity(for model: BagProductUIModel, count: Double)
    func sendEvent(_ action: BagViewModelEvent)
}

public protocol BagViewModelOutput: AnyObject {
    var stateChanged: ((BagViewModelState) -> Void)? { get set }
    var effectHandler: ((BagEffect) -> Void)? { get set }
    
    func numberOfSections() -> Int
    func section(at index: Int) -> BagSections?
    func indexForSection(_ sectionType: BagSectionType) -> Int?
    func indexOfProduct(_ model: BagProductUIModel) -> Int?
}

public typealias BagViewModelProtocol = BagViewModelInput & BagViewModelOutput
