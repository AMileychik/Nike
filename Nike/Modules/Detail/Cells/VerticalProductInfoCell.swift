//
//  VerticalProductInfoCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 4/8/25.
//

import UIKit

enum VerticalProductInfoCellDataType {
    case newFromNikeDetailSections(_ model: [NewFromNikeModel])
    case storiesForYouDetailSections(_ model: [StoriesForYou])
    case shopDetailSections(_ model: [Product])
    case verticalProductModel(_ model: [VerticalProductModel])
}

class VerticalProductInfoCell: UITableViewCell {
    
    private var productInfoCellDataType: VerticalProductInfoCellDataType?
    
    private var newFromNike: [NewFromNikeModel] = []
    private var storiesForYou: [StoriesForYou] = []
    private var product: [Product] = []
    private var special: [VerticalProductModel] = []
    
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(VerticalProductInfoCollectionViewCell.self)
        
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
    
    func updateCollectionViewHeight() {
        guard let dataType = productInfoCellDataType else { return }

        let width = UIScreen.main.bounds.width
        let itemHeight = width * 1.75

        var itemCount = 0

        switch dataType {
        case .newFromNikeDetailSections(let model):
            itemCount = model.first?.productData?.count ?? 0
        case .storiesForYouDetailSections(let model):
            itemCount = model.count
        case .shopDetailSections(let model):
            itemCount = model.count
        case .verticalProductModel(let model):
            itemCount = model.count
        }

        let totalHeight = CGFloat(itemCount) * itemHeight

        if let existing = heightConstraint {
            existing.constant = totalHeight
        } else {
            heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: totalHeight)
            heightConstraint?.priority = .defaultHigh
            heightConstraint?.isActive = true
        }
        
        layoutIfNeeded()
    }
}

// MARK: - Public
extension VerticalProductInfoCell {
    
    func update(dataType: VerticalProductInfoCellDataType) {
        self.productInfoCellDataType = dataType
        
        switch dataType {
        case .newFromNikeDetailSections(let model):
            self.newFromNike = model
        case .storiesForYouDetailSections(let model):
            self.storiesForYou = model
        case .shopDetailSections(let model):
            self.product = model
        case .verticalProductModel(let model):
            self.special = model
        }

        updateCollectionViewHeight()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension VerticalProductInfoCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataType = productInfoCellDataType else { return 0 }
        switch dataType {
        case .newFromNikeDetailSections(let model):
            return model.first?.productData?.count ?? 0
        case .storiesForYouDetailSections(let model):
            return model.count
        case .shopDetailSections(let model):
            return model.count
        case .verticalProductModel(let model):
            return model.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataType = productInfoCellDataType else { return UICollectionViewCell() }

        let cell = collectionView.dequeuCell(indexPath) as VerticalProductInfoCollectionViewCell

        switch dataType {
        case .newFromNikeDetailSections(let model):
            let product = model.first?.productData?[indexPath.item]
            if let product { cell.updateProductImage(product) }

        case .storiesForYouDetailSections(let model):
            cell.updateStoriesForYou(model[indexPath.item])

        case .shopDetailSections(let model):
            cell.updateShopVCSections(model[indexPath.item])

        case .verticalProductModel(let model):
            cell.updateVerticalProductModel(model[indexPath.item])
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VerticalProductInfoCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = width * 1.75
        return CGSize(width: width, height: height)
    }
}

// MARK: - Layout
extension VerticalProductInfoCell {
    
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
