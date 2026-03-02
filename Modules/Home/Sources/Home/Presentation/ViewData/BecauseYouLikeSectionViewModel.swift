//
//  File.swift
//
//
//  Created by Александр Милейчик on 12/30/25.
//

import Foundation

import AppDomain

// MARK: - Public

/// Section model for BecauseYouLike.
/// Generic over Item and Header types, which conform to respective protocols.
/// Contains a header, an array of items, and collection view item size.
public struct BecauseYouLikeSectionViewModel<
    Item: AnyItemProtocol,
    Header: BecauseYouLikeHeader
> {
    
    // MARK: - Properties
    
    /// Section header
    public let header: Header
    
    /// Section items
    public let items: [Item]
    
    /// Size of the collection view items
    public let itemSize: CGSize
    
    // MARK: - Init
    
    /// Creates a new section
    /// - Parameters:
    ///   - header: Section header
    ///   - items: Section items
    ///   - itemSize: Collection view item size
    public init(
        header: Header,
        items: [Item],
        itemSize: CGSize
    ) {
        self.header = header
        self.items = items
        self.itemSize = itemSize
    }
}

