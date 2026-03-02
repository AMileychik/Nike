//
//  DetailVC.swift
//  Nike
//
//  Created by Александр Милейчик on 10/28/24.
//

import UIKit

public final class DetailViewController: UIViewController {
    
    public let viewModel: DetailViewModelProtocol
//    public let tableView: DetailTableView
    public var tableView: (UIView & DetailTableViewProtocol)

    
    public init(tableView: (UIView & DetailTableViewProtocol),
        viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        self.tableView = tableView
 //       self.tableView = DetailTableView(detailViewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    public func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - Layout

public extension DetailViewController {
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailViewController: DetailDisplayingProtocol {
    public func reloadTable() {
        tableView.reloadData()
    }
    
    public func updateSections(_ sections: [DetailSection]) {
        viewModel.detailSections = sections
    }
}
