//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/10/25.
//

import UIKit

import AppDomain
import AppInterface

// MARK: - Home Sections Access

extension HomeViewModel {
    
    /// Returns the number of sections in the Home screen.
    public func numberOfSections() -> Int {
        homeSections.count
    }
    
    /// Returns the section model at the specified index.
    public func section(at index: Int) -> HomeSectionModel? {
        guard index >= 0 && index < homeSections.count else { return nil }
        return homeSections[index]
    }
}
