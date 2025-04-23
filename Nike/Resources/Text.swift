//
//  Text.swift
//  Nike
//
//  Created by Александр Милейчик on 3/13/25.
//

import Foundation

enum Text {
    
    enum TabBarController {
        static let home = "Home"
        static let shop = "Shop"
        static let favorite = "Favorite"
        static let bag = "Bag"
        static let profile = "Profile"
    }
    
    enum Home{
        static let explore = "Explore"
    }
    
    enum Bag {
        static let pay = "Pay"
        static let checkout = "Checkout"
        static let subtotal = "Subtotal"
    }
    
    enum QuantityPickerViewController {
        static let done = "Done"
    }
    
    enum Favorite {
        static let done = "Done"
        static let edit = "Edit"
    }
    
    enum Video {
        static let viewAll = "View All"
    }
    
    enum Detail {
        static let addedToBag = "Added to Bag"
        static let favorited = "Favorited"
    }
    
    enum ComingSoonViewController {
        static let greatThingsTakeTime = "Great things take time"
        static let seeYouSoon = "See You Soon"
    }
}
