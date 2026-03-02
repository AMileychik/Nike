//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/4/25.
//

import Foundation

public enum DetailData {
    case topPick(TopPickSelection)
    case promo([Product])
    case newFromNike([NewFromNikeModel])
    case verticalNew([NewFromNikeModel])
    case stories([StoriesForYou])
    case shop([Product])
    case shopList([Product])
    
    public var title: String? {
        switch self {
        case .topPick(let model): return model.products.first?.type
        case .promo(let model): return model.first?.type
        case .newFromNike(let model): return model.first?.title
        case .verticalNew(let model): return model.first?.title
        case .stories(let model): return model.first?.largeImageLabel1
        case .shop, .shopList: return nil
        }
    }
}
