//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//

import UIKit

import AppDomain

typealias StoriesForYouDefaultCell = StoriesForYouCell<StoriesForYouProps, Header>

final class StoriesForYouCellBuilder: HomeCellBuilding {
    
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {

        guard case .storiesForYou(let model) = section else { return UITableViewCell() }

        let cell: StoriesForYouDefaultCell = tableView.dequeueCell(indexPath)
                
        guard let props = model.items.first else { return cell }
        
        let section = StoriesForYouSection(
            header: model.header,
            props: props
        )
        
        cell.update(with: section)
        
        cell.onAction = { [weak actionHandler] action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        return cell
    }
}
