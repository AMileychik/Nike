//
//  DetailTableViewDataSource.swift
//  Nike
//
//  Created by Александр Милейчик on 3/23/25.
//

//import UIKit
//import AppDomain
//import DesignSystem
//
//public final class DetailTableViewAdapter: NSObject, UITableViewDataSource {
//    
//    public let detailViewModel: DetailViewModelProtocol
//    
//    public weak var delegate: CategoriesContainerDelegate?
//    public weak var completeTheLookProtocol: CompleteTheLookProtocol?
//
//    public init(detailViewModel: DetailViewModelProtocol, delegate: CategoriesContainerDelegate?, completeTheLookProtocol: CompleteTheLookProtocol?) {
//        self.detailViewModel = detailViewModel
//        self.delegate = delegate
//        self.completeTheLookProtocol = completeTheLookProtocol
//    }
//    
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        detailViewModel.numberOfSections()
//    }
//    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                
//        guard let section = detailViewModel.section(at: indexPath.section) else { return UITableViewCell() }
//               
//        switch section {
//
//    case .subCategories(let model):
//            let cell = tableView.dequeueCell(indexPath) as DetailProductsContainer
//            cell.update(model)
//            return cell
//            
//        case .categories(let model):
//            let cell = tableView.dequeueCell(indexPath) as CategoriesContainer
//            cell.delegate = delegate
//            let categories = model.compactMap { $0.categories }.flatMap { $0 }
//            cell.updateCategories(categories)
//            return cell
//            
//        case .description(let model):
//            let cell = tableView.dequeueCell(indexPath) as DescriptionCell
//            let data = model[indexPath.item]
//            cell.update(data)
//            return cell
//            
//        case .productSize(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as SizeContainer
//            cell.updateHeader(header)
//            cell.update(model, sectionHeight: 50)
//            return cell
//            
//        case .actionButtons(let model, let categories):
//            let cell = tableView.dequeueCell(indexPath) as DetailButtons
//            cell.update(model, current: categories)
//            cell.onAddToBag = { [weak detailViewModel] categories in
//                detailViewModel?.didRequestAddToBag(with: categories)
//            }
//            cell.onAddToFavorites = { [weak detailViewModel] categories in
//                detailViewModel?.didRequestAddToFavorites(with: categories)
//            }
//            return cell
//            
//        case .autoScrollingPageControl(let model):
//            let cell = tableView.dequeueCell(indexPath) as PromoCarouselCell
//            cell.update(model, sectionHeight: 150)
//            cell.isAutoScrollingEnabled = true
//            return cell
//            
//        case .productDescription(let model):
//            let cell = tableView.dequeueCell(indexPath) as ProductDescriptionCell
//            let data = model[indexPath.item]
//            cell.update(data)
//            return cell
//            
//        case .completeTheLook(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as CompleteTheLook
//            cell.updateHeader(header)
//            cell.update(model, sectionHeight: 375)
//            cell.delegate = completeTheLookProtocol
//            return cell
//            
//        case .productInfoCell(let model):
//            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
//            cell.update(dataType: .newFromNike(model))
//            return cell
//            
//        case .youMightAlsoLike(let model, let header):
//            let cell = tableView.dequeueCell(indexPath) as MediumSquareContainer
//            cell.updateYouMightAlsoLikeHeader(header)
//            cell.update(.oneMoremediumSquareCollectionViewCell(model: model), sectionHeight: 364)
//            return cell
//            
//        case .storiesForYou(let model):
//            let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
//            cell.update(dataType: .storiesForYouDetailSections(model))
//            return cell
//            
//        case .horizontalProductInfo(let model):
//            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
//            cell.update(dataType: .shopDetailSections(model))
//            return cell
//            
//        case .verticalProductInfoCell(let model):
//            let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
//            cell.update(dataType: .newFromNikeDetailSections(model))
//            return cell
//            
//        case .verticalWithProductModel(let model):
//            let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
//            cell.update(dataType: .verticalProductModel(model))
//            return cell
//            
//        case .productInfo(let model):
//            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
//            cell.update(dataType: .productInfo(model))
//            return cell
//            
//        case .descriptionModel(let model):
//            let cell = tableView.dequeueCell(indexPath) as DescriptionCell
//            let data = model[indexPath.item]
//            cell.update2(data)
//            return cell
//            
//        case .shopVCListCellSectiont(let model):
//            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
//            cell.update(dataType: .shopListDetailSections(model))
//            return cell
//        }
//    }
//}


import UIKit
import SharedUI

//public final class DetailTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
public final class DetailTableViewAdapter: NSObject, UITableViewDataSource {

    private let detailViewModel: DetailViewModelProtocol
    private weak var delegate: CategoriesContainerDelegate?
    private weak var completeTheLookProtocol: CompleteTheLookProtocol?
    private let cellFactory: DetailCellFactoryProtocol
    
    // MARK: - Init
    public init(
        detailViewModel: DetailViewModelProtocol,
        delegate: CategoriesContainerDelegate?,
        completeTheLookProtocol: CompleteTheLookProtocol?,
        cellFactory: DetailCellFactoryProtocol
    ) {
        self.detailViewModel = detailViewModel
        self.delegate = delegate
        self.completeTheLookProtocol = completeTheLookProtocol
        self.cellFactory = cellFactory
    }
    
    // MARK: - DataSource
        public func numberOfSections(in tableView: UITableView) -> Int {
            detailViewModel.numberOfSections()
        }
    
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = detailViewModel.section(at: indexPath.section) else {
            return UITableViewCell()
        }
        return cellFactory.makeCell(for: section, tableView: tableView, indexPath: indexPath)
    }
    
    // MARK: - Delegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
