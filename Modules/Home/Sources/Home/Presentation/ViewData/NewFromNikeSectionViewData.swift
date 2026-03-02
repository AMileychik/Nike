//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/29/25.
//

//import UIKit
//
//import AppDomain
//
//public struct NewFromNikeSectionViewData {
//
//    public let header: Header
//    public let rows: [NewFromNikeRowProps]
//}
//
//public struct NewFromNikeRowProps {
//
//    public enum Content {
//        case video(url: URL)
//        case product(ProductProps)
//    }
//
//    public let content: Content
//    public let height: CGFloat
//    public let addGradient: Bool
//}
//
//public struct ProductProps {
//
//    public let image: String
//    public let logoTitle: String
//    public let productData: [Product]
//    public let completeTheLookHeader: CompleteTheLookHeader
//    public let completeTheLookModel: [CompleteTheLookModel]
//}
//
//extension NewFromNikeRowProps {
//    func toModel() -> NewFromNikeModel {
//        switch content {
//        case .video(let url):
//            return NewFromNikeModel(
//                videoURL: url.absoluteString,
//                image: nil,
//                logoTitle: nil,
//                detailImage: nil,
//                title: nil,
//                description: nil,
//                productData: nil,
//                completeTheLookHeader: nil,
//                completeTheLookModel: nil
//            )
//        case .product(let props):
//            return NewFromNikeModel(
//                videoURL: nil,
//                image: props.image,
//                logoTitle: props.logoTitle,
//                detailImage: nil,
//                title: nil,
//                description: nil,
//                productData: props.productData,
//                completeTheLookHeader: props.completeTheLookHeader,
//                completeTheLookModel: props.completeTheLookModel
//            )
//        }
//    }
//}
