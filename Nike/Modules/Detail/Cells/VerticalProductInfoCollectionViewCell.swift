//
//  VerticalProductInfoCollectionViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 4/8/25.
//

import UIKit

class VerticalProductInfoCollectionViewCell: UICollectionViewCell {
    
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
extension VerticalProductInfoCollectionViewCell {
    
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
        titleLabel.text = model.largeImageLabel1
        descriptionLabel.text = model.fullDescription
    }
    
    func updateWith(_ model: NewFromNikeModel) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
    
    func updateShopVCSections(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        titleLabel.text = model.type
        descriptionLabel.text = model.description
    }
    
    func updateVerticalProductModel(_ model: VerticalProductModel) {
        photoImageView.image = UIImage(named: model.image ?? "")
        titleLabel.text = model.image?.description
        descriptionLabel.text = model.image?.description
    }
}

// MARK: - Layout
extension VerticalProductInfoCollectionViewCell {
    
    private func setupViews() {
        [photoImageView, titleLabel, descriptionLabel].forEach { contentView.addSubview($0) }
        
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 360),
            
            titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}
