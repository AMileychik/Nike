//
//  ShopTableView.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/30/24.
//

import UIKit

class ShopTableView: UITableView {
    
    private let presenter: IShopPresenterProtocol
    private let dataSourceManager: ShopTableViewDataSource
    
    init(presenter: IShopPresenterProtocol) {
        self.presenter = presenter
        self.dataSourceManager = ShopTableViewDataSource(presenter: presenter)
        super.init(frame: .zero, style: .plain)
        commonInit()

        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        separatorStyle = .none
        allowsSelection = false
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = dataSourceManager
    }
    
    private func registerCells() {
        registerCell(ButtonsCell.self)
        registerCell(HorizontalRectangleContainer.self)
        registerCell(NewsCell.self)
        registerCell(NewAndFeaturedContainer.self)
        registerCell(RecentlyViewedContainer.self)
        registerCell(LargeSquareContainer.self)
        registerCell(ClassicsSpotlightCell.self)
        registerCell(MediumSquareContainer.self)
    }
}

// MARK: - TableViewDelegate
extension ShopTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = presenter.sections(at: indexPath.section) else { return 0 }
        switch section {
        
        case .news:
            return 110
        default:
            return UITableView.automaticDimension
        }
    }
}

