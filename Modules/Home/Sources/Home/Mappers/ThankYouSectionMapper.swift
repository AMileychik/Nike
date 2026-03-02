//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/28/25.
//

import UIKit

import AppDomain
import AppInterface

public protocol ThankYouSectionMapperProtocol {
    func map(_ model: ThankYouSectionModel) -> ThankYouViewData
}

public final class ThankYouSectionMapper: ThankYouSectionMapperProtocol {
    public func map(_ model: ThankYouSectionModel) -> ThankYouViewData {
        ThankYouViewData(image: UIImage(named: model.image))
    }
}
