//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/21/25.
//

import Foundation

public enum Text {
    
    public enum TabBarController {
        public static let home = "Home"
        public static let shop = "Shop"
        public static let favorite = "Favorite"
        public static let bag = "Bag"
        public static let profile = "Profile"
    }
    
    public enum Home {
        public static let explore = "Explore"
    }
    
    public enum Bag {
        public static let pay = "Pay"
        public static let checkout = "Checkout"
        public static let subtotal = "Subtotal"
    }
    
    public enum QuantityPickerViewController {
        public static let done = "Done"
    }
    
    public enum Favorite {
        public static let done = "Done"
        public static let edit = "Edit"
    }
    
    public enum Video {
        public static let viewAll = "View All"
    }
    
    public enum Detail {
        public static let addedToBag = "Added to Bag"
        public static let favorited = "Favorited"
    }
    
    public enum ComingSoonViewControllerText {
        public static let greatThingsTakeTime = "Great things take time"
        public static let seeYouSoon = "See You Soon"
    }
}
