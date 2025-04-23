//
//  RecentlyViewedCollectionViewCell.swift
//  Nike
//
//  Created by Александр Милейчик on 11/30/24.
//

import UIKit

class RecentlyViewedCollectionCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .recentlyViewed)
    private let nameLabel = Label(type: .titleDescription)
    private let priceLabel = Label(type: .subTitleDescription)
    private let horizontalStackView = StackView(type: .productCell)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public
extension RecentlyViewedCollectionCell {
    
    func updateRecentlyViewed(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.description
              
        if let price = model.price {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = nil
        }
    }
}

//MARK: - Layout
extension RecentlyViewedCollectionCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(nameLabel)
        horizontalStackView.addArrangedSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
