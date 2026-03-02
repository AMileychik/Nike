//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public struct ShopSectionsResponse: Codable {
    public let buttonsSection: ShopButtonsModel
    public let men: ShopVCMenModels
    public let women: ShopVCWomenModels
    public let kids: ShopVCKidsModels
    
    public init(
        buttonsSection: ShopButtonsModel,
        men: ShopVCMenModels,
        women: ShopVCWomenModels,
        kids: ShopVCKidsModels
    ) {
        self.buttonsSection = buttonsSection
        self.men = men
        self.women = women
        self.kids = kids
    }
}
