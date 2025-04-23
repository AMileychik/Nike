//
//  ScrollToTop + Extention.swift
//  Nike
//
//  Created by Александр Милейчик on 1/28/25.
//

import UIKit

extension UITableView {
    
    func scrollToTop(animated: Bool = true) {
        
        let topOffset = CGPoint(x: 0, y: -adjustedContentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}
