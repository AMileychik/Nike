//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/23/25.
//

import UIKit

import AppDomain
import DesignSystem

final class PromoCellBuilder: HomeCellBuilding {
    
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        section: HomeFeatureSection,
        actionHandler: HomeCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        guard case .promo(let section) = section else {
            return UITableViewCell()
        }
        
        let cell: PromoCarouselCell = tableView.dequeueCell(indexPath)
        
        cell.configure(with: section.viewData, itemHeight: 150)
        
        cell.onAction = { action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        cell.onStartAutoScrollRequested = {
            section.viewModel.onPageChange = { index in
                DispatchQueue.main.async {
                    cell.scrollToPage(index)
                }
            }
            section.viewModel.startAutoScroll()
        }
        
        cell.onStopAutoScrollRequested = {
            section.viewModel.stopAutoScroll()
        }
        
        return cell
    }
}
