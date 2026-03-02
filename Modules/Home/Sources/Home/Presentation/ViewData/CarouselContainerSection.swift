//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppDomain

public struct CarouselContainerSection<Item: AnyItemProtocol, Header: BecauseYouLikeHeader> {
    public let header: Header
    public let items: [Item]
    public let itemSize: CGSize

    public init(
        header: Header,
        items: [Item],
        itemSize: CGSize = CGSize(width: 150, height: 280)
    ) {
        self.header = header
        self.items = items
        self.itemSize = itemSize
    }
}
