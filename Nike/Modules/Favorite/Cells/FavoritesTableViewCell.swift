//
//  FavoriteVCTableViewCell.swift
//  Nike
//
//  Created by Александр Милейчик on 11/13/24.
//

import UIKit

protocol FavoritesTableViewCellDelegate: AnyObject {
    func presentComingSoonViewController()
}

final class FavoritesTableViewCell: UITableViewCell {
    
    weak var delegate: FavoritesTableViewCellDelegate?
    private let favoritesService: FavoritesServiceProtocol = FavoritesService()
    private var productModel: [SubCategoryModel] = []
    private var isEditingFavorites: Bool = false
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 24
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(FavoriteCollectionViewCell.self)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public
extension FavoritesTableViewCell {
    
    func update(_ model: [SubCategoryModel], isEditing: Bool = false) {
        self.productModel = model.map {
            var item = $0
            if item.isHeartFilled == nil {
                item.isHeartFilled = false
            }
            return item
        }
        self.isEditingFavorites = isEditing
        updateCollectionViewHeight()
        collectionView.reloadData()
    }
    
    func updateCollectionViewHeight() {
        let rows = ceil(Double(productModel.count) / 2.0)
        let itemWidth = (UIScreen.main.bounds.width - (3 * 1)) / 2
        let itemHeight = itemWidth * 1.5
        let lineSpacing: CGFloat = 24
        let totalHeight = (rows * itemHeight) + ((rows - 1) * lineSpacing) + 8
        
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = totalHeight
            
        } else {
            let heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: totalHeight)
            heightConstraint.priority = .defaultHigh
            heightConstraint.isActive = true
        }
    }
}

//MARK: - Action Handler
extension FavoritesTableViewCell {
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? FavoriteCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        toggleHeart(forItemAt: indexPath)
    }
    
    func toggleHeart(forItemAt indexPath: IndexPath) {
        guard indexPath.item < productModel.count else { return }
        if let isHeartFilled = productModel[indexPath.item].isHeartFilled {
            productModel[indexPath.item].isHeartFilled = !isHeartFilled
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

//MARK: - UICollectionViewDataSource
extension FavoritesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(indexPath) as FavoriteCollectionViewCell
        
        let model = productModel[indexPath.item]
        cell.update(model, isEditing: isEditingFavorites)
        
        let isHeartFilled = model.isHeartFilled ?? false
        cell.deleteButton.setImage(isHeartFilled ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill"), for: .normal)
        
        cell.deleteButton.addTarget(self, action: #selector(heartButtonTapped(_:)), for: .touchUpInside)
        
        cell.onRemoveFromFavorites = { [weak self] in
            guard let self = self else { return }
            let updatedData = self.favoritesService.delete(model)
            self.productModel = updatedData
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? FavoriteCollectionViewCell
        cell?.onSelectItem?()
        delegate?.presentComingSoonViewController()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpacing = (2 * 1) + 2
        let width = (collectionView.bounds.width - CGFloat(totalSpacing)) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

// MARK: - Layout
extension FavoritesTableViewCell {
    
    private func setupView() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}




