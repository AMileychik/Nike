//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import UIKit

public protocol BagCellDelegate: AnyObject {
    func didRequestDeleteItem(at indexPath: IndexPath, model: BagProductUIModel)
    func didRequestEditQuantity(for model: BagProductUIModel)
}
