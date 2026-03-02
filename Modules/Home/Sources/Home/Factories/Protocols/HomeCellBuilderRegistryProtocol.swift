//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/27/25.
//

import AppDomain

protocol HomeCellBuilderRegistryProtocol {
    func builder(for section: HomeSections) -> HomeCellBuilding
}
