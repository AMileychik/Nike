//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/12/25.
//

import UIKit
import DesignSystem
import AppDomain

public final class DetailCellFactory: DetailCellFactoryProtocol {

    private weak var viewModel: DetailViewModelProtocol?
    private weak var manager: DetailTableViewManager?

    public init(viewModel: DetailViewModelProtocol,
                manager: DetailTableViewManager?)
    {
        self.viewModel = viewModel
        self.manager = manager
    }
}

// MARK: - Public Methods

extension DetailCellFactory {

    public func makeCell(for section: DetailSection, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
       
        switch section {

        case .subCategories(let model):
            return makeSubCategoriesCell(model: model, tableView: tableView, indexPath: indexPath)

        case .categories(let model):
            return makeCategoriesCell(model: model, tableView: tableView, indexPath: indexPath)

        case .description(let model):
            return makeDescriptionCell(model: model, tableView: tableView, indexPath: indexPath)

        case .productSize(let model, let header):
            return makeProductSizeCell(model: model, header: header, tableView: tableView, indexPath: indexPath)

        case .actionButtons(let model, let categories):
            return makeActionButtonsCell(model: model, subCategories: categories, tableView: tableView, indexPath: indexPath)

        case .autoScrollingPageControl(let model):
            return makeAutoScrollingPageControlCell(model: model, tableView: tableView, indexPath: indexPath)

        case .productDescription(let model):
            return makeProductDescriptionCell(model: model, tableView: tableView, indexPath: indexPath)

        case .completeTheLook(let model, let header):
            return makeCompleteTheLookCell(model: model, header: header, tableView: tableView, indexPath: indexPath)

        case .productInfoCell(let model):
            return makeProductInfoCell(model: model, tableView: tableView, indexPath: indexPath)

        case .youMightAlsoLike(let model, let header):
            return makeYouMightAlsoLikeCell(model: model, header: header, tableView: tableView, indexPath: indexPath)

        case .storiesForYou(let model):
            return makeStoriesForYouCell(model: model, tableView: tableView, indexPath: indexPath)

        case .horizontalProductInfo(let model):
            return makeHorizontalProductInfoCell(model: model, tableView: tableView, indexPath: indexPath)

        case .verticalProductInfoCell(let model):
            return makeVerticalProductInfoCell(model: model, tableView: tableView, indexPath: indexPath)

        case .verticalWithProductModel(let model):
            return makeVerticalWithProductModelCell(model: model, tableView: tableView, indexPath: indexPath)

        case .productInfo(let model):
            return makeProductInfo(model: model, tableView: tableView, indexPath: indexPath)

        case .descriptionModel(let model):
            return makeDescriptionModelCell(model: model, tableView: tableView, indexPath: indexPath)

        case .shopVCListCellSectiont(let model):
            return makeShopVCListCellSectiontCell(model: model, tableView: tableView, indexPath: indexPath)
        }
    }
}

// MARK: - Private Cell Builders

private extension DetailCellFactory {

    func makeSubCategoriesCell(model: [SubCategoryModel], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as DetailProductsContainer
        cell.update(model)
        return cell
    }

    func makeCategoriesCell(model: [Product], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as CategoriesContainer
        cell.delegate = manager
        let categories = model.compactMap { $0.categories }.flatMap { $0 }
        cell.updateCategories(categories)
        return cell
    }

    func makeDescriptionCell(model: [Product], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as DescriptionCell
        let data = model[indexPath.item] // or let data = model[indexPath.row]???
        cell.update(data)
        return cell
    }

    func makeProductSizeCell(model: [ProductSize], header: Header, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as SizeContainer
        cell.updateHeader(header)
        cell.update(model, sectionHeight: 50)
        return cell
    }

    func makeActionButtonsCell(model: DetailButtonsModel, subCategories: SubCategoryModel, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as DetailButtons
        cell.update(model, current: subCategories)
        cell.onAddToBag = { [weak viewModel] categories in
            viewModel?.didRequestAddToBag(with: categories)
        }
        cell.onAddToFavorites = { [weak viewModel] categories in
            viewModel?.didRequestAddToFavorites(with: categories)
        }
        return cell
    }

    func makeAutoScrollingPageControlCell(model: [Product], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as PromoCarouselCell
     //   cell.update(model, height: 150)
        
        // Do editional layer for mapping like HomeFeatureSectionBuilder or use dataViewModel here instead og Product model
        
        let viewData = PromoCarouselViewData(pages: model.map { $0.toPromoPageViewData() })
            
        cell.configure(with: viewData, itemHeight: 150)
       
        // replace PromoCarouselViewModel to AppDomain and use for different features (common logic) i would call it BaseViewModel with scrolling and etc
        
//        cell.onStartAutoScrollRequested = {
//            section.viewModel.onPageChange = { index in
//                DispatchQueue.main.async {
//                    cell.scrollToPage(index)
//                }
//            }
//            section.viewModel.startAutoScroll()
//        }
//        
//        cell.onStopAutoScrollRequested = {
//            section.viewModel.stopAutoScroll()
//        }
//        cell.isAutoScrollingEnabled = true
        return cell
    }

    func makeProductDescriptionCell(model: [ProductDescription], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as ProductDescriptionCell
        let data = model[indexPath.item]
        cell.update(data)
        return cell
    }

    func makeCompleteTheLookCell(model: [CompleteTheLookModel], header: CompleteTheLookHeader, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as CompleteTheLook
        cell.updateHeader(header)
        cell.update(model, sectionHeight: 375)
        cell.delegate = manager
        return cell
    }

    func makeProductInfoCell(model: [NewFromNikeModel], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
        cell.update(dataType: .newFromNike(model))
        return cell
    }

    func makeYouMightAlsoLikeCell(model: [YouMightAlsoLikeModel], header: YouMightAlsoLikeHeader, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as MediumSquareContainer
        cell.updateYouMightAlsoLikeHeader(header)
        cell.update(.oneMoremediumSquareCollectionViewCell(model: model), sectionHeight: 364)
        return cell
    }

    func makeStoriesForYouCell(model: [StoriesForYou], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
        cell.update(dataType: .storiesForYouDetailSections(model))
        return cell
    }

    func makeHorizontalProductInfoCell(model: [Product], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
        cell.update(dataType: .shopDetailSections(model))
        return cell
    }

    func makeVerticalProductInfoCell(model: [NewFromNikeModel], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
        cell.update(dataType: .newFromNikeDetailSections(model))
        return cell
    }

    func makeVerticalWithProductModelCell(model: [VerticalProductModel], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
        cell.update(dataType: .verticalProductModel(model))
        return cell
    }
    
    func makeProductInfo(model: [ProductInfo], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
        cell.update(dataType: .productInfo(model))
        return cell
    }

    func makeDescriptionModelCell(model: [Description], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as DescriptionCell
        let data = model[indexPath.item]
        cell.update2(data)
        return cell
    }

    func makeShopVCListCellSectiontCell(model: [ProductInfo], tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
        cell.update(dataType: .shopListDetailSections(model))
        return cell
    }
}
