//
//  DetailTableViewDataSource.swift
//  LagomStore
//
//  Created by Александр Милейчик on 3/23/25.
//

import UIKit

enum DetailSection {
    case subCategories([SubCategoryModel])
    case categories([Product])
    case description([Product])
    case productSize([ProductSize], header: Header)
    case actionButtons(DetailButtonsModel, subCategories: SubCategoryModel)
    case autoScrollingPageControl([Product])
    case productDescription([ProductDescription])
    case completeTheLook([CompleteTheLookModel], header: CompleteTheLookHeader)
    case productInfoCell([NewFromNikeModel])
    case storiesForYou([StoriesForYou])
    case youMightAlsoLike([YouMightAlsoLikeModel], header: YouMightAlsoLikeHeader)
    case horizontalProductInfo([Product])
    case shopVCListCellSectiont([ProductInfo])
    case productInfo([ProductInfo])
    case verticalProductInfoCell([NewFromNikeModel])
    case verticalWithProductModel([VerticalProductModel])
    case descriptionModel([Description])
}

final class DetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    var detailSections: [DetailSection] = []
    weak var tableView: UITableView?
    private var bagService: BagServiceProtocol
    private var favoritesService: FavoritesServiceProtocol
    private var selectedSubCategory: SubCategoryModel?

    init(tableView: UITableView, 
         bagService: BagServiceProtocol,
         favoritesService: FavoritesServiceProtocol) {
        
        self.tableView = tableView
        self.bagService = bagService
        self.favoritesService = favoritesService
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailSectionsData = detailSections[indexPath.section]
        switch detailSectionsData {
            
        case .subCategories(let model):
            
            let cell = tableView.dequeueCell(indexPath) as DetailProductsContainer
            cell.update(model)
            return cell
            
        case .categories(let model):
            
            let cell = tableView.dequeueCell(indexPath) as CategoriesContainer
            cell.delegate = self
            let categories = model.compactMap { $0.categories }.flatMap { $0 }
            cell.updateCategories(categories)
            return cell
            
        case .description(let model):
            
            let cell = tableView.dequeueCell(indexPath) as DescriptionCell
            let data = model[indexPath.item]
            cell.update(data)
            return cell
            
        case .productSize(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as SizeContainer
            cell.updateHeader(header)
            cell.update(model, sectionHeight: 50)
            return cell
            
        case .actionButtons(let model, let categories):
            
            let cell = tableView.dequeueCell(indexPath) as DetailButtons
            cell.update(model, current: categories)
            
            cell.onAddToBag = { [weak self] categories in
                guard let self = self else { return }
                self.handleAddToBag(categories)
            }
            
            cell.onAddToFavorites = { [weak self] categories in
                guard let self = self else { return }
                self.handleAddToFavorites(categories)
            }
            return cell
            
        case .autoScrollingPageControl(let model):
            
            let cell = tableView.dequeueCell(indexPath) as PromoCarouselCell
            cell.update(model, sectionHeight: 150)
            cell.isAutoScrollingEnabled = true
            return cell
            
        case .productDescription(let model):
            
            let cell = tableView.dequeueCell(indexPath) as ProductDescriptionCell
            let data = model[indexPath.item]
            cell.update(data)
            return cell
            
        case .completeTheLook(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as CompleteTheLook
            cell.updateHeader(header)
            cell.update(model, sectionHeight: 375)
            return cell
            
        case .productInfoCell(let model):
            
            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
            cell.update(dataType: .newFromNike(model))
            return cell
            
        case .youMightAlsoLike(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as MediumSquareContainer
            cell.updateYouMightAlsoLikeHeader(header)
            cell.update(.oneMoremediumSquareCollectionViewCell(model: model), sectionHeight: 364)
            return cell
        
        case .storiesForYou(let model):
            
            let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
            cell.update(dataType: .storiesForYouDetailSections(model))
            return cell
        
        case .horizontalProductInfo(let model):
            
            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
            cell.update(dataType: .shopDetailSections(model))
            return cell
        
        case .verticalProductInfoCell(let model):
            
           let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
           cell.update(dataType: .newFromNikeDetailSections(model))
           return cell
       
        case .verticalWithProductModel(let model):
            
            let cell = tableView.dequeueCell(indexPath) as VerticalProductInfoCell
            cell.update(dataType: .verticalProductModel(model))
            return cell
        
        case .productInfo(let model):
            
            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
            cell.update(dataType: .productInfo(model))
            return cell
        
        case .descriptionModel(let model):
            
            let cell = tableView.dequeueCell(indexPath) as DescriptionCell
            let data = model[indexPath.item]
            cell.update2(data)
            return cell
       
        case .shopVCListCellSectiont(let model):
            let cell = tableView.dequeueCell(indexPath) as HorizontalProductInfoCell
            cell.update(dataType: .shopListDetailSections(model))
            return cell
        }
    }
    
    private func handleAddToBag(_ categories: [SubCategoryModel]) {
        if let selectedSubCategoryID = selectedSubCategory {
            bagService.saveAndAdd([selectedSubCategoryID])
            
        } else if let firstSubCategory = categories.first {
            selectedSubCategory = firstSubCategory
            bagService.saveAndAdd([firstSubCategory])
            
        } else {
            print("No subCategories")
        }
    }
    
    private func handleAddToFavorites(_ categories: [SubCategoryModel]) {
        if let selectedSubCategoryID = selectedSubCategory {
            favoritesService.saveAndAdd([selectedSubCategoryID])
            
        } else if let firstSubCategory = categories.first {
            selectedSubCategory = firstSubCategory
            favoritesService.saveAndAdd([firstSubCategory])
            
        } else {
            print("No subCategories")
        }
    }
}

// MARK: - CategoriesContainerDelegate
extension DetailTableViewDataSource: CategoriesContainerDelegate {
    
    func didSelectSubCategory(with model: [SubCategoryModel], 
                              subCategory: String) {
        
        detailSections[0] = .subCategories(model)
        tableView?.reloadData()
    }
    
    func didSelectCategory(_ subCategory: SubCategoryModel) {
        selectedSubCategory = subCategory
    }
}
