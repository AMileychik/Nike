//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

//import UIKit
//import AppInterface
//
//public final class ShopTableView: UITableView {
//    
//    private let presenter: ShopPresenterProtocol
//    private let adapter: ShopTableViewAdapter
//    
//    public init(presenter: ShopPresenterProtocol) {
//        self.presenter = presenter
//        self.adapter = ShopTableViewAdapter(presenter: presenter)
//        super.init(frame: .zero, style: .plain)
//        commonInit()
//        registerCells()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func commonInit() {
//        separatorStyle = .none
//        allowsSelection = false
//        translatesAutoresizingMaskIntoConstraints = false
//        delegate = self
//        dataSource = adapter
//    }
//    
//    private func registerCells() {
//        registerCell(ButtonsCell.self)
//        registerCell(HorizontalRectangleContainer.self)
//        registerCell(NewsCell.self)
//        registerCell(NewAndFeaturedContainer.self)
//        registerCell(RecentlyViewedContainer.self)
//        registerCell(LargeSquareContainer.self)
//        registerCell(ClassicsSpotlightCell.self)
//        registerCell(MediumSquareContainer.self)
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension ShopTableView: UITableViewDelegate {
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = presenter.sections(at: indexPath.section) else { return 0 }
//        switch section {
//        case .news:
//            return 110
//        default:
//            return UITableView.automaticDimension
//        }
//    }
//}
