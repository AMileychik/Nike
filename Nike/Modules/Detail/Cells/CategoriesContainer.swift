//
//  TableViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/3/24.
//

import UIKit

protocol CategoriesContainerDelegate: AnyObject {
    func didSelectSubCategory(with model: [SubCategoryModel], subCategory: String)
    func didSelectCategory(_ subCategory: SubCategoryModel)
}

final class CategoriesContainer: UITableViewCell {
      
    weak var delegate: CategoriesContainerDelegate?
    
    private var favoritesService: FavoritesServiceProtocol = FavoritesService()
    private var categories: [Categories] = []
    private var subCategoryModel: [SubCategoryModel] = []

    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCell(CategoriesCollectionViewCell.self)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension CategoriesContainer {
    
    func updateCategories(_ model: [Categories]) {
        self.categories = model
        self.subCategoryModel = model.first?.subCategories ?? []
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesContainer: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as CategoriesCollectionViewCell
        let categories = categories[indexPath.item]
        cell.updateCategories(categories)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
}

//MARK: - UICollectionViewDelegate
extension CategoriesContainer: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedSubCategory = categories[indexPath.item].subCategories?.first else { return }
        guard let subCategoryName = selectedSubCategory.category else { return }
        
        if let delegate = delegate {
            delegate.didSelectSubCategory(with: categories[indexPath.item].subCategories ?? [], subCategory: subCategoryName)
            delegate.didSelectCategory(selectedSubCategory)
        }
    }
}

//MARK: - Layout
extension CategoriesContainer {
    
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 108)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}















