//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

//import UIKit
//import ShopCore
//import AppInterface
//import AppCore
//import AppDomain
//
//public final class ShopTableViewAdapter: NSObject, UITableViewDataSource {
//    
//    private let presenter: ShopPresenterProtocol
//        
//    public init(presenter: ShopPresenterProtocol) {
//        self.presenter = presenter
//    }
//    
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        presenter.numberOfSections()
//    }
//    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let sectionData = presenter.sections(at: section) else { return 0 }
//        switch sectionData {
//        case .news(let model):
//            return model.count
//        default:
//            return 1
//        }
//    }
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let section = presenter.sections(at: indexPath.section) else { return UITableViewCell() }
//
//        switch section {
//        case .buttons(let model):
//            let cell = tableView.dequeueCell(indexPath) as ButtonsCell
//            cell.menButtonAction = { [weak self] index in self?.handleButtonTap(index: index) }
//            cell.womenButtonAction = { [weak self] index in self?.handleButtonTap(index: index) }
//            cell.kidsButtonAction = { [weak self] index in self?.handleButtonTap(index: index) }
//            cell.updateButtonCell(model)
//            return cell
//
//        case .newThisWeek(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as HorizontalRectangleContainer
//            cell.delegate = self
//            cell.updateHeader(header)
//            cell.update(dataType: .newThisWeek(model), sectionHeight: 225)
//            return cell
//
//        case .news(let model):
//            let cell = tableView.dequeueCell(indexPath) as NewsCell
//            let item = model[indexPath.row]
//            cell.updateNewsCell(with: item)
//            cell.onPhotoTapped = { [weak self] in
//        //        self?.presenter.didSelectProduct(data: .shopList([item]))
//            }
//            cell.setupPhotoImageTappedAction()
//            return cell
//
//        case .newAndFeatured(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as NewAndFeaturedContainer
//            cell.delegate = self
//            cell.updateHeader(header)
//            cell.update(model, sectionHeight: 250)
//            return cell
//
//        case .rafaelNadal(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as LargeSquareContainer
//            cell.delegate = self
//            cell.updateHeader(header)
//            cell.update(.nearbyStoreSectionData(models: model), sectionHeight: 308)
//            return cell
//
//        case .recentlyViewed(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as RecentlyViewedContainer
//            cell.delegate = self
//            cell.updateHeader(header)
//            cell.observe()
//            cell.update(model, sectionHeight: 225)
//            cell.onRemoveSection = { [weak self] in
//                guard let self = self else { return }
//                let type = self.presenter.selectedButtonType()
//                self.presenter.removeRecentlyViewed(for: type)
//            }
//            return cell
//
//        case .classicsSpotlightCell(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as RecentlyViewedContainer
//            cell.delegate = self
//            cell.updateHeader(header)
//            cell.update(model, sectionHeight: 200)
//            return cell
//
//        case .nearbyStore(model: let model, header: let header):
//            let cell = tableView.dequeueCell(indexPath) as MediumSquareContainer
//            cell.delegate = self
//            cell.updateHeader(header)
//            cell.observe()
//            cell.update(.mediumSquareCollectionViewCell(models: model), sectionHeight: 364)
//            return cell
//        }
//    }
//}
//
//// MARK: - Private
//private extension ShopTableViewAdapter {
//    func handleButtonTap(index: Int) {
//        presenter.handleButtonTap(index)
//    }
//}
//
//// MARK: - Delegates
//extension ShopTableViewAdapter: HorizontalRectangleContainerDelegate {
//    public func didSelectProduct(_ product: Product) {
//     //   presenter.didSelectProduct(data: .shop([product]))
//    }
//}
//
//extension ShopTableViewAdapter: RecentlyViewedContainerContainerDelegate {
//    public func didSelectRecentlyViewed(_ product: Product) {
//   //     presenter.didSelectProduct(data: .shop([product]))
//    }
//}
//
//extension ShopTableViewAdapter: ClassicsSpotlightCellDelegate {
//    public func didSelectClassicsSpotlight(_ product: Product) {
//   //     presenter.didSelectProduct(data: .shop([product]))
//    }
//}
//
//extension ShopTableViewAdapter: MediumSquareCellDelegate {
//    public func didSelectMediumSquareCell(_ product: Product) {
//   //     presenter.didSelectProduct(data: .shop([product]))
//    }
//
//    public func didSelectMediumSquareCell2(_ product: YouMightAlsoLikeModel) {
//        // пока не реализовано
//    }
//}
//
//extension ShopTableViewAdapter: NewAndFeaturedContainerDelegate {
//    public func didSelectNewAndFeatured(_ product: Product) {
//  //      presenter.didSelectProduct(data: .shop([product]))
//    }
//}
//
//extension ShopTableViewAdapter: LargeSquareContainerDelegate {
//    public func didSelectLargeSquareCell(_ product: Product) {
//   //     presenter.didSelectProduct(data: .shop([product]))
//    }
//}
