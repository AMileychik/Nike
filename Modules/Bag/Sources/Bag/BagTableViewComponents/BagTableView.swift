//
//  BagTableView.swift
//  
//
//  Created by Александр Милейчик on 6/19/25.
//

import UIKit

public final class BagTableView: UITableView, BagTableViewProtocol {

    private let manager: BagTableViewManager
    private let adapter: BagTableViewAdapter

    public init(viewModel: BagViewModelProtocol,
                frame: CGRect = .zero,
                style: UITableView.Style = .plain)
    {
        self.manager = BagTableViewManager(viewModel: viewModel)
        self.adapter = BagTableViewAdapter(viewModel: viewModel, delegate: manager)
        super.init(frame: frame, style: style)
        manager.configure(tableView: self, adapter: adapter)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
