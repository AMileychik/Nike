//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import Foundation

import AppDomain
import DesignSystem

public struct StoriesForYouSectionViewData {

    public let header: Header
    public let items: [StoriesForYouProps]

    public init(
        header: Header,
        items: [StoriesForYouProps]
    ) {
        self.header = header
        self.items = items
    }
}

public struct NewFromNikeSectionViewData {

    public let header: Header
    public let rows: [NewFromNikeRowProps]
    
    public init(header: Header, rows: [NewFromNikeRowProps]) {
        self.header = header
        self.rows = rows
    }
}
