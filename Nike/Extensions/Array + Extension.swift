//
//  Array + Extension.swift
//  LagomStore
//
//  Created by Александр Милейчик on 2/7/25.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
