//
//  DetailVCPageControlCollectionViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/13/24.
//

import UIKit

final class DetailProductsCollectionCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .common)
    private let titleLabel = Label(type: .screenTitle)
    private let descriptionLabel = Label(type: .subTitleDescription)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension DetailProductsCollectionCell {
   
    func update(_ model: SubCategoryModel) {
        photoImageView.image = UIImage(named: model.subCategoryImage ?? "")
    }
    
    func updateProductImage(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        titleLabel.text = model.type
        descriptionLabel.text = model.description
    }
    
    func updateStoriesForYou(_ model: StoriesForYou) {
        photoImageView.image = UIImage(named: model.largeImage)
    }
    
    func updateWith(_ model: NewFromNikeModel) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
    
    func updateShopVCSections(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
    
    func updateSimple(_ model: ProductInfo) {
        photoImageView.image = UIImage(named: model.image ?? "")
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    func updateShopVCListCellSections(_ model: Product) {
        photoImageView.image = UIImage(named: model.image2 ?? "")
        descriptionLabel.text = model.description
    }
}

// MARK: - Layout
extension DetailProductsCollectionCell {
    
    private func setupViews() {
        [photoImageView, titleLabel, descriptionLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}





