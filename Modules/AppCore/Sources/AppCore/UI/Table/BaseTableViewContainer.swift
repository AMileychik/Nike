//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/21/25.
//

import UIKit

open class BaseTableViewContainer: UIView {
    
    public private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    public init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) { fatalError() }
}

public extension BaseTableViewContainer {
    public func bind(controller: BaseTableControllerProtocol) {
        tableView.dataSource = controller.dataSource
        tableView.delegate = controller.delegate
        controller.registerCells(in: tableView)
        controller.configure(tableView: tableView)
    }
}

// MARK: - Layout

private extension BaseTableViewContainer {
    func setupViews() {
        addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}



