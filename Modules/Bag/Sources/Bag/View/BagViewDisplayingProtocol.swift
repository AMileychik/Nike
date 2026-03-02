//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import DesignSystem
import UIKit

public protocol BagViewDisplayingProtocol: AnyObject {
    func scrollToTop()
    func reloadTable()
    var bagButtonsView: (UIView & BagButtonsViewProtocol) { get }
}
