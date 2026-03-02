//
//  DetailTableView.swift
//  Nike
//
//  Created by Александр Милейчик on 10/28/24.
//

//import UIKit
//import DesignSystem
//
//public final class DetailTableView: UITableView, DetailTableViewProtocol {
//    
//    public let adapter: DetailTableViewAdapter
//    public let manager: DetailTableViewManager
//    private let cellFactory: DetailCellFactory
//    
//    public init(detailViewModel: DetailViewModelProtocol, 
//                frame: CGRect = .zero,
//                style: UITableView.Style = .plain) 
//    {
//        self.manager = DetailTableViewManager(viewModel: detailViewModel)
//        self.adapter = DetailTableViewAdapter(detailViewModel: detailViewModel, 
//                                              delegate: manager,
//                                              completeTheLookProtocol: manager,
//                                              cellFactory: cellFactory)
//        super.init(frame: frame, style: style)
//        manager.configure(tableView: self, adapter: adapter)
//    }
//    
//    
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


import UIKit
import DesignSystem

public final class DetailTableView: UITableView, DetailTableViewProtocol {
    
    public let adapter: DetailTableViewAdapter
    public let manager: DetailTableViewManager
    private let cellFactory: DetailCellFactory
    
    public init(
        detailViewModel: DetailViewModelProtocol,
        frame: CGRect = .zero,
        style: UITableView.Style = .plain
    ) {
        // 1️⃣ Сначала создаём manager
        let manager = DetailTableViewManager(viewModel: detailViewModel)
        self.manager = manager
        
        // 2️⃣ Потом создаём factory
        let cellFactory = DetailCellFactory(viewModel: detailViewModel, manager: manager)
        self.cellFactory = cellFactory
        
        // 3️⃣ Теперь adapter — после того, как factory уже готов
        self.adapter = DetailTableViewAdapter(
            detailViewModel: detailViewModel,
            delegate: manager,
            completeTheLookProtocol: manager,
            cellFactory: cellFactory
        )
        
        super.init(frame: frame, style: style)
        
        // 4️⃣ Конфигурируем таблицу
        manager.configure(tableView: self, adapter: adapter)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

