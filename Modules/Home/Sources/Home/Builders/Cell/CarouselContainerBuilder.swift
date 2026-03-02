//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/21/25.
//

import UIKit

import AppDomain

typealias CarouselContainerDefaultCell = CarouselContainer<AnyItemModel, Header>

final class CarouselContainerBuilder: HomeCellBuilding {
    
    private let uiFactory: HomeUIComponentsFactoryProtocol

    init(uiFactory: HomeUIComponentsFactoryProtocol) {
        self.uiFactory = uiFactory
    }

    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {

        guard case .becauseYouLike(let viewData) = section else {
            return UITableViewCell()
        }

        let cell: CarouselContainerDefaultCell =
            tableView.dequeueCell(indexPath)

        let headerButton = uiFactory.makeHeaderButton()
        cell.setHeaderButton(headerButton)
        
        let section = CarouselContainerSection(
            header: viewData.header,
            items: viewData.items)
        
        cell.configure(with: section)

        cell.onAction = { [weak actionHandler] action in
            actionHandler?.handle(action, at: indexPath)
        }

        return cell
    }
}

