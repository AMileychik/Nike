//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/20/25.
//

import Foundation

public protocol BecauseYouLikeHeader {
    var title: String? { get }
    var subtitle: String? { get }
    var buttonTitle: String? { get }
}

public struct Header: Codable {
    public let title: String?
    public let subtitle: String?
    public let buttonTitle: String?
    
    public init(
        title: String?,
        subtitle: String?,
        buttonTitle: String?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
}

extension Header: BecauseYouLikeHeader {}



//Можно использовать в разных фичах
//    •    Поскольку ячейка generic и независима, одинаковая секция может быть показана в разных местах приложения.
//    •    Для другой фичи создаём другой Item/Header mapper или другой JSON — интерфейс остаётся прежним.
//    •    Не нужно дублировать UI-код или писать отдельные ячейки под каждый кейс.
//
//
//
//
//1. HomeCoordinatorDependencies — лучше public
//
//Сейчас они internal по умолчанию.
//Если пакет SPM — лучше явно указывать access level.
//
//🔸 4. TableViewContainer — можно добавить separator inset / background config
//
//3. табы определены enum’ом TabItem или лучше каждый таб в отдельном классе?
//
//5. Можно вынести URL в эндпоинты
//6. CoordinatorDependencies можно было держать в Protocol-ориентированном виде.
//7. Можно упростить связывание RefreshControl
//
//Сейчас:
//    •    vc.attachRefreshControl()
//    •    плюс addTarget
//8.
//
//. StateHandler print(error)
//
//В реальном проекте лучше отправлять в Logger / Metric.
