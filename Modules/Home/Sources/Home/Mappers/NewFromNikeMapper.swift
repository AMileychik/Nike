//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

import Foundation

import AppDomain
import DesignSystem

public protocol NewFromNikeMapperProtocol {
    func map(_ model: NewFromNikeSectionModel) -> NewFromNikeSectionViewData
}

public final class NewFromNikeMapper: NewFromNikeMapperProtocol {

    public init() {}

    public func map(_ model: NewFromNikeSectionModel) -> NewFromNikeSectionViewData {

        let lastIndex = model.products.count - 1

        let rows: [NewFromNikeRowProps] = model.products.enumerated().compactMap { index, product in

//            if let video = product.videoURL,
//               let url = Bundle.main.url(forResource: video, withExtension: "mp4") {
//                
//                                return NewFromNikeRowProps(
//                                    content: .video(url: url),
//                                    height: 250,
//                                    addGradient: true
//                                )
//                
//                
//            }
            
            if let video = product.videoURL {
                return NewFromNikeRowProps(
                    content: .video(
                        .init(
                            videoURL: video,
                            description: product.description,
                            image: product.image
                        )
                    ),
                    height: 250,
                    addGradient: true
                )
            }
            


            guard
                let image = product.image,
                let logoTitle = product.logoTitle,
                let description = product.description,
                let productData = product.productData,
                let header = product.completeTheLookHeader,
                let items = product.completeTheLookModel
            else {
                return nil
            }

            let props = ProductProps(
                image: image,
                logoTitle: logoTitle,
                description: description,
                productData: productData,
                completeTheLookHeader: header,
                completeTheLookModel: items
            )

            return NewFromNikeRowProps(
                content: .product(props),
                height: 500,
                addGradient: index == lastIndex
            )
        }

        return NewFromNikeSectionViewData(
            header: model.header,
            rows: rows
        )
    }
}
