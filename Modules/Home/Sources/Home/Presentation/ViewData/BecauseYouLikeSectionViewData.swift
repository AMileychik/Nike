//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation

import AppDomain
import DesignSystem

public struct BecauseYouLikeSectionViewData {

    public let header: Header
    public let items: [AnyItemModel]

    public init(
        header: Header,
        items: [AnyItemModel]
    ) {
        self.header = header
        self.items = items
    }
}
