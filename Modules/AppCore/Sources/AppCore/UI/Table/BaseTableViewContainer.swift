//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/21/25.
//

import UIKit

// MARK: - BaseTableViewContainer

/// A reusable base container for table views.
///
/// Initializes a tableView, sets up layout, and binding to a controller responsible for:
/// - providing dataSource & delegate,
/// - registering cells,
/// - configuring table appearance and behavior
open class BaseTableViewContainer: UIView {
    
    // MARK: - Properties
    
    /// The main table view managed by the container.
    public private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /// The controller responsible for data, delegate, cell registration, and table configuration.
    private var controller: BaseTableControllerProtocol

    // MARK: - Initialization
    
    /// Initializes the container with a controller and binds it automatically.
    public init(controller: BaseTableControllerProtocol) {
        self.controller = controller
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        bindController()
    }
    
    /// Not supported from storyboard/XIB.
    @available(*, unavailable)
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Binding

public extension BaseTableViewContainer {
    
    /// Binds a controller to the table view.
    func bindController() {
        tableView.dataSource = controller.dataSource
        tableView.delegate = controller.delegate
        controller.registerCells(in: tableView)
        controller.configure(tableView: tableView)
    }
}

// MARK: - Layout

private extension BaseTableViewContainer {
    
    /// Adds subviews to the container.
    func setupViews() {
        addSubview(tableView)
    }
    
    /// Activates constraints for the table view to fill the container.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
