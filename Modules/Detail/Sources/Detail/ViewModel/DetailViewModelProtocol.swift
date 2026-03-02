//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/3/25.
//

import UIKit
import AppCore
import AppDomain
import AppInterface

public protocol DetailViewModelInput: AnyObject {
    func updateSelectedSubCategory(_ model: SubCategoryModel)
    func didRequestAddToBag(with categories: [SubCategoryModel])
    func didRequestAddToFavorites(with categories: [SubCategoryModel])
    func sendEvent(_ action: DetailViewModelEvent)
    func loadData(_ data: DetailData)
}

public protocol DetailViewModelOutput: AnyObject {
    var detailSections: [DetailSection] { get set}
    var stateChanged: ((DetailViewModelState) -> Void)? { get set }
    var effectHandler: ((DetailEffect) -> Void)? { get set }
    
    func numberOfSections() -> Int
    func section(at index: Int) -> DetailSection?
}

public typealias DetailViewModelProtocol = DetailViewModelInput & DetailViewModelOutput
