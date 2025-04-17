//
//  ClassicsSpotlightContainerCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/24/25.
//

import UIKit

class ClassicsSpotlightCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .product)
    
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
extension ClassicsSpotlightCollectionViewCell {
    
    func update(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
}

//MARK: - Layout
extension ClassicsSpotlightCollectionViewCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
