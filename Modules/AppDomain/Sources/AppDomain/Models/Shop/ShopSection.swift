//
//  File.swift
//
//
//  Created by Александр Милейчик on 7/6/25.
//

import Foundation

public enum ShopSection {
    case buttons(ShopButtonsModel)
    case newThisWeek(model: [Product], header: Header)
    case news([Product])
    case newAndFeatured(model: [Product], header: Header)
    case rafaelNadal(model: [Product], header: Header)
    case recentlyViewed(model: [Product], header: Header)
    case classicsSpotlightCell(model: [Product], header: Header)
    case nearbyStore(model: [Product], header: Header)
}
