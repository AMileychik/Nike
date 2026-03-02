//
//  BagViewController.swift
//
//
//  Created by Александр Милейчик on 6/18/25.
//

import UIKit
import DesignSystem
import AppCore

public final class BagViewController: UIViewController {
    
    // Implement MARK: -
    
    public let bagButtonsView: (UIView & BagButtonsViewProtocol)
    public let bagTableView: (UIView & BagTableViewProtocol)
    private let viewModel: BagViewModelProtocol
    
    public init(viewModel: BagViewModelProtocol,
                bagTableView: (UIView & BagTableViewProtocol),
                buttonsView: UIView & BagButtonsViewProtocol)
    {
        self.viewModel = viewModel
        self.bagTableView = bagTableView
        self.bagButtonsView = buttonsView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateSections()
    }
    
// MARK: - Private Methods
    
    private func configureNavigationBar() {
        title = Text.TabBarController.bag
        navigationController?.setupNavigationBar()
    }
}

// MARK: - Scrollable

extension BagViewController: Scrollable {
    public func scrollToTop() {
        bagTableView.scrollToTop(animated: true)
    }
}

// MARK: - BagViewDisplayingProtocol

extension BagViewController: BagViewDisplayingProtocol {
    public func reloadTable() {
        bagTableView.reloadData()
    }
}

// MARK: - Layout Setup

extension BagViewController {
    
    func setupViews() {
        view.addSubview(bagTableView)
        view.addSubview(bagButtonsView)
    }
    
    func setupConstraints() {
        bagTableView.translatesAutoresizingMaskIntoConstraints = false
        bagButtonsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bagTableView.topAnchor.constraint(equalTo: view.topAnchor),
            bagTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bagTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bagTableView.bottomAnchor.constraint(equalTo: bagButtonsView.topAnchor),
            
            bagButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bagButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bagButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bagButtonsView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

