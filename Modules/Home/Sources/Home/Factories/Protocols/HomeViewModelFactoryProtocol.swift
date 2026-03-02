//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/9/25.
//

import Foundation
import AppInterface
import DesignSystem
import AppDomain

public protocol HomeViewModelFactoryProtocol {
    func makeHomeViewModel(
        sectionBuilder: HomeSectionBuildingProtocol,
        errorMapper:HomeErrorMapping
    ) -> HomeViewModelProtocol
    
    func makePromoCarouselViewModel(
        for pages: [PromoPageViewData]
    ) -> PromoCarouselViewModelProtocol
}
