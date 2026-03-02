//
//  TableViewCell.swift
//  Nike
//
//  Created by Александр Милейчик on 11/3/24.
//

import UIKit
import AppDomain

public protocol CategoriesContainerDelegate: AnyObject {
    func didSelectSubCategory(with model: [SubCategoryModel], subCategory: String)
    func didSelectCategory(_ subCategory: SubCategoryModel)
}

public final class CategoriesContainer: UITableViewCell {
      
    public weak var delegate: CategoriesContainerDelegate?
   // private var favoritesService: FavoritesServiceProtocol = FavoritesService(repository: FavoritesUserDefaultsRepository())
    public var categories: [Categories] = []
    public var subCategoryModel: [SubCategoryModel] = []

    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCell(CategoriesCollectionViewCell.self)
        
        return collectionView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension CategoriesContainer {
    
    public func updateCategories(_ model: [Categories]) {
        self.categories = model
        self.subCategoryModel = model.first?.subCategories ?? []
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesContainer: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeuCell(indexPath) as CategoriesCollectionViewCell
        let categories = categories[indexPath.item]
        cell.updateCategories(categories)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesContainer: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 96)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
}

//MARK: - UICollectionViewDelegate
extension CategoriesContainer: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    public func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    public func setupConstraints() {
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















