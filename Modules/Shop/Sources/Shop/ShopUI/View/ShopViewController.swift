//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

//import UIKit
//import AppCore
//import DesignSystem
//import AppInterface
//
//public final class ShopViewController: UIViewController {
//    
//    private let presenter: ShopPresenterProtocol
//    private var tableView: ShopTableView
//    private let activityIndicator = UIActivityIndicatorView(style: .large)
//        
//    public weak var shopRouter: ShopCoordinatorProtocol?
//
//    public init(presenter: ShopPresenterProtocol) {
//        self.presenter = presenter
//        self.tableView = ShopTableView(presenter: presenter)
//        super.init(nibName: nil, bundle: nil)
//        self.presenter.view = self
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        configureNavigationBar()
//        setupView()
//        setupConstraints()
//        presenter.viewDidLoad()
//        activityIndicator.startAnimating()
//    }
//    
//    private func configureNavigationBar() {
//        title = "Shop"
//        navigationController?.setupNavigationBar() // из AppCore / AppUI
//    }
//}
//
//// MARK: - Navigation
//extension ShopViewController {
////    public func navigateToDetailVC(data: DetailData) {
////        shopRouter?.showDetail(data: data)
////    }
//}
//
//extension ShopViewController: ShopRoutableProtocol {}
//
//// MARK: - Scrollable
//extension ShopViewController: Scrollable {
//    public func scrollToTop() {
//        tableView.scrollToTop(animated: true)
//    }
//}
//
//// MARK: - ShopViewControllerProtocol
//extension ShopViewController: ShopViewControllerProtocol {
//    
//    public func updateView() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            self.activityIndicator.stopAnimating()
//        }
//    }
//    
//    public func startLoading() {
//        DispatchQueue.main.async {
//            self.activityIndicator.startAnimating()
//        }
//    }
//}
//
//// MARK: - Layout
//private extension ShopViewController {
//    
//    func setupView() {
//        view.addSubview(tableView)
//        view.addSubview(activityIndicator)
//        
//        activityIndicator.tintColor = .gray
//        activityIndicator.color = .black
//    }
//    
//    func setupConstraints() {
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}
