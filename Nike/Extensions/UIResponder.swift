//
//  UIResponder.swift
//  Nike
//
//  Created by Александр Милейчик on 2/20/25.
//

import UIKit

extension UIResponder {
    
    func findParentViewController() -> UIViewController? {
        var responder: UIResponder? = self
        
        while let next = responder?.next {
            if let vc = next as? UIViewController { return vc }
            responder = next
        }
        return nil
    }
}
