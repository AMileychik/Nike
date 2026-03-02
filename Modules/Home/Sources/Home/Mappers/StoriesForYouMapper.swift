//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//

import AppDomain

public protocol StoriesForYouMapperProtocol {
    func map(_ model: StoriesForYou) -> StoriesForYouProps
}

public final class StoriesForYouMapper: StoriesForYouMapperProtocol {
    
    public init() {}

    public func map(_ model: StoriesForYou) -> StoriesForYouProps {
        StoriesForYouProps(
            product: model,
            title: model.title,
            rightButtonTitle: model.rightButtonTitle,
            large: model.largeImage, 
            largeImageLabel1: model.largeImageLabel1,
            small1: model.smallImage1,
            small2: model.smallImage2,
            bottomButtonTitle: model.bottomButtonTitle
        )
    }
}
