//
//  HomeTableView.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/29/24.
//

import UIKit

class HomeTableView: UITableView {
    
    private let homeViewModel: HomeViewModel
    private let dataSourceManager: HomeTableViewDataSource
    
    init(homeViewModel: HomeViewModel, 
         frame: CGRect = .zero,
         style: UITableView.Style = .plain) {
       
        self.homeViewModel = homeViewModel
        self.dataSourceManager = HomeTableViewDataSource(homeViewModel: homeViewModel)
        super.init(frame: frame, style: style)
        commonInit()
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        separatorStyle = .none
        allowsSelection = false
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = dataSourceManager
    }
    
    private func registerCells() {
        registerCell(WelcomeCell.self)
        registerCell(BecauseYouLikeContainer.self)
        registerCell(PromoCarouselCell.self)
        registerCell(NewFromNikeCell.self)
        registerCell(StoriesForYouCell.self)
        registerCell(ThankYouCell.self)
    }
}
