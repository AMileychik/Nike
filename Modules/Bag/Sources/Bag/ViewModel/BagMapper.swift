//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/10/25.
//

import AppDomain
import AppInterface

public final class BagMapper {
    
    public static func mapToUIModel(from model: SubCategoryModel) -> BagProductUIModel {
        BagProductUIModel(
            id: model.id ?? 0,
            image: model.subCategoryImage ?? "",
            title: model.title ?? "",
            category: model.category ?? "",
            count: model.count ?? 0.0,
            price: model.price ?? 0.0,
            isHeartFilled: model.isHeartFilled ?? false)
    }
    
    public static func mapToDomainModel(from model: BagProductUIModel) -> SubCategoryModel {
        SubCategoryModel(
            id: model.id,
            subCategoryImage: model.image,
            title: model.title,
            category: model.category,
            count: Double(model.count ?? 0.0),
            price: Double(model.price ?? 0.0),
            isHeartFilled: model.isHeartFilled
        )
    }
}

