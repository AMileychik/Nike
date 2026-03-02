//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/1/26.
//

import Foundation

import AppDomain

public struct NewFromNikeSectionModel {
    let header: Header
    let products: [NewFromNikeModel]

    var rowHeights: [CGFloat] {
        products.map {
            $0.videoURL != nil ? 250 : 500
        }
    }

    var gradientIndexes: [Int] {
        guard !products.isEmpty else { return [] }
        return [products.count - 1]
    }
}
