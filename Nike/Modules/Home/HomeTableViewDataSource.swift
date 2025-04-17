//
//  HomeTableViewDataSource.swift
//  LagomStore
//
//  Created by Александр Милейчик on 3/23/25.
//

import UIKit

enum HomeSection {
    case welcome(String)
    case becauseYouLike([Product], header: Header)
    case promo([Product])
    case newFromNike([NewFromNikeModel], header: Header)
    case storiesForYou([StoriesForYou])
    case thankYou([Product])
}

class HomeTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let sectionData = homeViewModel.section(at: indexPath.section) else { return UITableViewCell() }
        switch sectionData {
            
        case .welcome(let text):
            
            let cell = tableView.dequeueCell(indexPath) as WelcomeCell
            cell.update(text)
            return cell
            
        case .becauseYouLike(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as BecauseYouLikeContainer
            cell.becauseYouLikeContainerDelegate = self
            cell.updateHeader(header)
            cell.update(dataType: .product(model))
            cell.setupHeaderButtonAction()
           
            cell.onHeaderButtonTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.headerButtonDidTap, from: tableView.viewController)
            }
            return cell
            
        case .promo(let model):
            
            let cell = tableView.dequeueCell(indexPath) as PromoCarouselCell
            let promoCellHeight: CGFloat = 150
            cell.promoCarouselCellDelegate = self
            cell.update(model, sectionHeight: promoCellHeight)
            cell.isAutoScrollingEnabled = false
            return cell
            
        case .newFromNike(let model, let header):
            
            let cell = tableView.dequeueCell(indexPath) as NewFromNikeCell
            cell.newFromNikeCellDelegate = self
            cell.updateHeader(header)
            cell.setupHeaderButtonAction()
            
            let listHeights: [CGFloat] = [500, 500, 500, 250]
            cell.update(model, heights: listHeights, gradientIndexes: [3])
            
            cell.onHeaderButtonTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.exploreButtonDidTap(model))
            }
            
            cell.onExploreButtonTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.exploreButtonDidTap(model))
            }
            
            cell.onButtomTappedTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.exploreButtonDidTap(model))
            }
            return cell
            
        case .storiesForYou(let model):
            
            let cell = tableView.dequeueCell(indexPath) as StoriesForYouCell
            let model = model[indexPath.row]
            cell.update(model)
            
            cell.onHeaderButtonTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.headerButtonDidTap, from: tableView.viewController)
            }
            cell.onLargeImageTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.storiesForYouDidTap([model]), from: tableView.viewController)
            }
            
            cell.onSmallImage1Tapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.headerButtonDidTap, from: tableView.viewController)
            }
            
            cell.onSmallImage2Tapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.headerButtonDidTap, from: tableView.viewController)
            }
            
            cell.onBottomButtonTapped = { [weak homeViewModel] in
                homeViewModel?.sendEvent(.storiesForYouDidTap([model]), from: tableView.viewController)
            }
            
            cell.setupHeaderButtonAction()
            cell.setupBottomButtonAction()
            cell.setupLargeImageTappedAction()
            cell.setupSmallImageView1Action()
            cell.setupSmallImageView2Action()
            return cell
            
        case .thankYou(let model):
            
            let cell = tableView.dequeueCell(indexPath) as ThankYouCell
            let model = model[indexPath.row]
            cell.update(model)
            return cell
        }
    }
}

//MARK: - BecauseYouLikeContainerDelegate
extension HomeTableViewDataSource: BecauseYouLikeContainerDelegate {
    
    func didSelectItem(model: [Product], categories: Categories?, header: Header?, category: String, subCategory: SubCategoryModel?) {
        
        homeViewModel.sendEvent(.homeTopPicksDidTap(model: model,
                                                    categories: categories,
                                                    header: header,
                                                    category: category,
                                                    subCategory: subCategory))
    }
}

//MARK: - PromoCarouselCellDelegate
extension HomeTableViewDataSource: PromoCarouselCellDelegate {
   
    func didSelectItem(model: [Product]) {
        homeViewModel.sendEvent(.promoDidTap(model))
    }
}

//MARK: - NewFromNikeCellDelegate
extension HomeTableViewDataSource: NewFromNikeCellDelegate {
    
    func didSelectItem(model: [NewFromNikeModel]) {
        homeViewModel.sendEvent(.newFromNikeDidTap(model))
    }
}





