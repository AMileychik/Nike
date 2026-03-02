//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/22/25.
//

import UIKit

extension UITableView {
    public func scrollToTop(animated: Bool = true) {
        let topIndex = IndexPath(row: 0, section: 0)
        if numberOfSections > 0, numberOfRows(inSection: 0) > 0 {
            scrollToRow(at: topIndex, at: .top, animated: animated)
        } else {
            setContentOffset(.zero, animated: animated)
        }
    }
}


