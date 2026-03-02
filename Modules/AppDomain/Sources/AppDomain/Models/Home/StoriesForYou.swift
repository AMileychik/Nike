//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct StoriesForYou: Codable {
    public let largeImage: String
    public let smallImage1: String
    public let smallImage2: String
    public let largeImageLabel1: String
    public let largeImageLabel2: String
    public let smallImage1Label1: String
    public let smallImage1Label2: String
    public let smallImage2Label1: String
    public let smallImage2Label2: String
    public let title: String
    public let rightButtonTitle: String
    public let bottomButtonTitle: String
    public let fullDescription: String?
    
    public init(
        largeImage: String,
        smallImage1: String,
        smallImage2: String,
        largeImageLabel1: String,
        largeImageLabel2: String,
        smallImage1Label1: String,
        smallImage1Label2: String,
        smallImage2Label1: String,
        smallImage2Label2: String,
        title: String,
        rightButtonTitle: String,
        bottomButtonTitle: String,
        fullDescription: String?
    ) {
        self.largeImage = largeImage
        self.smallImage1 = smallImage1
        self.smallImage2 = smallImage2
        self.largeImageLabel1 = largeImageLabel1
        self.largeImageLabel2 = largeImageLabel2
        self.smallImage1Label1 = smallImage1Label1
        self.smallImage1Label2 = smallImage1Label2
        self.smallImage2Label1 = smallImage2Label1
        self.smallImage2Label2 = smallImage2Label2
        self.title = title
        self.rightButtonTitle = rightButtonTitle
        self.bottomButtonTitle = bottomButtonTitle
        self.fullDescription = fullDescription
    }
}
