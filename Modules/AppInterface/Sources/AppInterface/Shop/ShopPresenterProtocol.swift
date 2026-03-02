//
//  File.swift
//
//
//  Created by Александр Милейчик on 7/6/25.
//

import Foundation
import AppDomain

public protocol ShopPresenterProtocol: AnyObject {
    var view: ShopViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func handleButtonTap(_ index: Int)
    func numberOfSections() -> Int
    func sections(at index: Int) -> ShopSection?
    func selectedButtonType() -> ButtonDataType
    func removeRecentlyViewed(for buttonType: ButtonDataType)
//    func didSelectProduct(data: DetailData)
}
