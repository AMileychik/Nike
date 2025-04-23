//
//  BagVC.swift
//  Nike
//
//  Created by Александр Милейчик on 12/13/24.
//

import UIKit

final class BagViewController: UIViewController {
    
    private let bagService: BagServiceProtocol
    private var tableView = BagTableView()
    private let buttonsView = UIView()
    private let separatorView = UIView.makeSeparator()
    
    private let payButton = CustomButton(
        title: Text.Bag.pay,
        backgroundColor: .white,
        titleColor: .black,
        cornerRadius: 22,
        font: UIFont.systemFont(ofSize: 24, weight: .medium),
        iconImage: Image.applelogo,
        iconSize: CGSize(width: 20, height: 24)
    )
    
    private let checkoutButton = CustomButton(
        title: Text.Bag.checkout,
        backgroundColor: .black,
        titleColor: .white,
        cornerRadius: 22)
    
    init(bagService: BagServiceProtocol = BagService()) {
        self.bagService = bagService
        super.init(nibName: nil, bundle: nil)
        self.tableView.parentViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupViews()
        setupConstraints()
        setupButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBagSections()
    }
    
    private func setupStyle() {
        title = "Bag"
        navigationController?.setupNavigationBar()
    }
    
    private func setupButtonActions() {
        payButton.onButtonTapped = { [weak self] in
            self?.handlePayButtonTap() }
        
        checkoutButton.onButtonTapped = { [weak self] in
            self?.handleCheckoutButtonTap() }
    }
}

//MARK: - Scrollable
extension BagViewController: Scrollable {
    func scrollToTop() {
        tableView.scrollToTop(animated: true)
    }
}

//MARK: - Action Handler
extension BagViewController {
    
    private func handlePayButtonTap() {
        let comingSoonVC = dependencyContainer.screenFactory.createComingSoonScreen()
        comingSoonVC.modalPresentationStyle = .fullScreen
        present(comingSoonVC, animated: true)
    }
    
    private func handleCheckoutButtonTap() {
        let comingSoonVC = dependencyContainer.screenFactory.createComingSoonScreen()
        comingSoonVC.modalPresentationStyle = .fullScreen
        present(comingSoonVC, animated: true)
    }
}

// MARK: - Data Loading
extension BagViewController {
    
    private func updateBagSections() {
        let fetchedProducts = bagService.fetch()
        let totalPrice = bagService.calculateTotalPrice()
        
        tableView.bagSections = BagSectionBuilder.createBagSections(
            from: fetchedProducts,
            totalPrice: totalPrice)
        
        tableView.reloadData()
    }
}

// MARK: - Layout
extension BagViewController  {
    
    private func setupViews() {
        [tableView, buttonsView].forEach { view.addSubview($0) }
        [separatorView, payButton, checkoutButton].forEach { buttonsView.addSubview($0) }
        
        buttonsView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        [tableView, buttonsView, payButton, checkoutButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonsView.topAnchor),
            
            separatorView.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor),
            
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 100),
            
            payButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 24),
            payButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
            payButton.heightAnchor.constraint(equalToConstant: 46),
            payButton.widthAnchor.constraint(equalToConstant: 164),
            
            checkoutButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -24),
            checkoutButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 46),
            checkoutButton.widthAnchor.constraint(equalToConstant: 164)
        ])
    }
}






