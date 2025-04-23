//
//  ShopTableViewDataSource.swift
//  Nike
//
//  Created by Александр Милейчик on 3/23/25.
//

import UIKit

enum ShopSection {
    case buttons(ShopButtonsModel)
    case newThisWeek(model: [Product], header: Header)
    case news([Product])
    case newAndFeatured(model: [Product], header: Header)
    case rafaelNadal(model: [Product], header: Header)
    case recentlyViewed(model: [Product], header: Header)
    case classicsSpotlightCell(model: [Product], header: Header)
    case nearbyStore(model: [Product], header: Header)
}

class ShopTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let presenter: IShopPresenterProtocol
        
    init(presenter: IShopPresenterProtocol) {
        self.presenter = presenter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = presenter.sections(at: section) else { return 0 }
        switch sectionData {
            
        case .news(let model):
            return model.count
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = presenter.sections(at: indexPath.section) else { return UITableViewCell() }
        switch sections {
            
        case .buttons(let model):
            
            let cell = tableView.dequeueCell(indexPath) as ButtonsCell
            
            cell.menButtonAction = { [weak self] index in
                self?.handleButtonTap(index: index)
            }
            cell.womenButtonAction = { [weak self] index in
                self?.handleButtonTap(index: index)
            }
            cell.kidsButtonAction = { [weak self] index in
                self?.handleButtonTap(index: index)
            }
            cell.updateButtonCell(model)
            return cell
            
        case .newThisWeek(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as HorizontalRectangleContainer
            cell.delegate = self
            cell.updateHeader(header)
            cell.update(dataType: .newThisWeek(model), sectionHeight: 225)
            return cell
             
        case .news(let model):
            
            let cell = tableView.dequeueCell(indexPath) as NewsCell
            let model = model[indexPath.row]
            cell.updateNewsCell(with: model)
            
            cell.onPhotoTapped = {
                self.presenter.didSelectListCellProduct(model)
            }
            
            cell.setupPhotoImageTappedAction()
            return cell
            
        case .newAndFeatured(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as NewAndFeaturedContainer
            cell.delegate = self
            cell.updateHeader(header)
            cell.update(model, sectionHeight: 250)
            return cell
            
        case .rafaelNadal(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as LargeSquareContainer
            cell.delegate = self
            cell.updateHeader(header)
            cell.update(.nearbyStoreSectionData(models: model), sectionHeight: 308)
            return cell
            
        case .recentlyViewed(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as RecentlyViewedContainer
            cell.delegate = self
            cell.updateHeader(header)
            cell.observe()
            cell.update(model, sectionHeight: 225)
            
            cell.onRemoveSection = { [weak self] in
                guard let self = self else { return }
                let buttonType = presenter.selectedButtonType()
                presenter.removeRecentlyViewed(for: buttonType)
            }
            return cell
            
        case .classicsSpotlightCell(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as RecentlyViewedContainer
            cell.delegate = self
            cell.updateHeader(header)
            cell.update(model, sectionHeight: 200)
            return cell
            
        case .nearbyStore(model: let model, header: let header):
            
            let cell = tableView.dequeueCell(indexPath) as MediumSquareContainer
            cell.delegate = self
            cell.updateHeader(header)
            cell.observe()
            cell.update(.mediumSquareCollectionViewCell(models: model), sectionHeight: 364)
            return cell
        }
    }
}

extension ShopTableViewDataSource {
    func handleButtonTap(index: Int) {
        presenter.handleButtonTap(index)
    }
}

//MARK: - HorizontalRectangleContainerDelegate
extension ShopTableViewDataSource: HorizontalRectangleContainerDelegate {
    func didSelectProduct(_ product: Product) {
        presenter.didSelectProduct(product)
    }
}

//MARK: - RecentlyViewedContainerContainerDelegate
extension ShopTableViewDataSource: RecentlyViewedContainerContainerDelegate {
    func didSelectRecentlyViewed(_ product: Product) {
        presenter.didSelectProduct(product)
    }
}

//MARK: - ClassicsSpotlightCellDelegate
extension ShopTableViewDataSource: ClassicsSpotlightCellDelegate {
    func didSelectClassicsSpotlight(_ product: Product) {
        presenter.didSelectProduct(product)
    }
}

//MARK: - MediumSquareCellDelegate
extension ShopTableViewDataSource: MediumSquareCellDelegate {
    func didSelectMediumSquareCell(_ product: Product) {
        presenter.didSelectProduct(product)
    }
    func didSelectMediumSquareCell2(_ product: YouMightAlsoLikeModel) {}
}

//MARK: - NewAndFeaturedContainerDelegate
extension ShopTableViewDataSource: NewAndFeaturedContainerDelegate {
    func didSelectNewAndFeatured(_ product: Product) {
        presenter.didSelectProduct(product)
    }
}

//MARK: - LargeSquareContainerDelegate
extension ShopTableViewDataSource: LargeSquareContainerDelegate {
    func didSelectLargeSquareCell(_ product: Product) {
        presenter.didSelectProduct(product)
    }
}
