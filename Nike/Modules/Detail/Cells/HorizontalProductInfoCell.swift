//
//  ProductInfoCell.swift
//  Nike
//
//  Created by Александр Милейчик on 4/2/25.
//

import UIKit

enum ProductInfoCellDataType {
    case newFromNike(_ model: [NewFromNikeModel])
    case storiesForYou(_ model: [StoriesForYou])
    case shopDetailSections(_ model: [Product])
    case shopListDetailSections(_ model: [ProductInfo])
    case productInfo(_ model: [ProductInfo])
}

class HorizontalProductInfoCell: UITableViewCell {
    
    private var productInfoCellDataType: ProductInfoCellDataType?

    private var newFromNike: [NewFromNikeModel] = []
    private var storiesForYou: [StoriesForYou] = []
    private var product: [Product] = []
    private var productInfo: [ProductInfo] = []
    
    private let titleLabel = Label(type: .screenTitle)
    private let descriptionLabel = Label(type: .subTitleDescription)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(DetailProductsCollectionCell.self)
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
extension HorizontalProductInfoCell {
    
    func update(dataType: ProductInfoCellDataType) {
        self.productInfoCellDataType = dataType
        switch dataType {
            
        case .newFromNike(let model):
            self.newFromNike = model
            titleLabel.text = model.first?.title
            descriptionLabel.text = model.first?.description
            collectionView.reloadData()

        case .storiesForYou(let model):
            self.storiesForYou = model
            titleLabel.text = model.first?.title
            descriptionLabel.text = model.first?.bottomButtonTitle
            collectionView.reloadData()
       
        case .shopDetailSections(let model):
            self.product = model
            titleLabel.text = model.first?.type
            descriptionLabel.text = model.first?.fullDescription
            collectionView.reloadData()
        
        case .productInfo(let model):
            self.productInfo = model
            titleLabel.text = model.first?.title
            descriptionLabel.text = model.first?.description
            collectionView.reloadData()
        
        case .shopListDetailSections(let model):
            self.productInfo = model
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HorizontalProductInfoCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataType = productInfoCellDataType else { return 0 }
        switch dataType {

        case .newFromNike(let model):
            return model.count
        case .storiesForYou(let model):
            return model.count
        case .shopDetailSections(let model):
            return model.count
        case .productInfo(let model):
            return model.count
        case .shopListDetailSections(let model):
            return model.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataType = productInfoCellDataType else { return UICollectionViewCell() }
        switch dataType {
            
        case .newFromNike(let model):
            
            let cell = collectionView.dequeuCell(indexPath) as DetailProductsCollectionCell
            let data = model[indexPath.item]
            cell.updateWith(data)
            return cell
      
        case .storiesForYou(let model):
            
            let cell = collectionView.dequeuCell(indexPath) as DetailProductsCollectionCell
            let data = model[indexPath.item]
            cell.updateStoriesForYou(data)
            return cell
        
        case .shopDetailSections(let model):
            
            let cell = collectionView.dequeuCell(indexPath) as DetailProductsCollectionCell
            let data = model[indexPath.item]
            cell.updateShopVCSections(data)
            return cell
       
        case .productInfo(let model):
            
            let cell = collectionView.dequeuCell(indexPath) as DetailProductsCollectionCell
            let data = model[indexPath.item]
            cell.updateSimple(data)
            return cell
        
        case .shopListDetailSections(let model):
            
            let cell = collectionView.dequeuCell(indexPath) as DetailProductsCollectionCell
            let data = model[indexPath.item]
            cell.updateSimple(data)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HorizontalProductInfoCell: UICollectionViewDelegate {}

//MARK: - Layout
extension HorizontalProductInfoCell {
    
    private func setupViews() {
        [collectionView, titleLabel, descriptionLabel].forEach { contentView.addSubview($0) }
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            
            titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalProductInfoCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
    


