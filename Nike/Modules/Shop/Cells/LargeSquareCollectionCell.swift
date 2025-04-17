//
//  NearbyStoresCollectionViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/22/24.
//

import UIKit

class LargeSquareCollectionCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .nearbySection)
    private let nameLabel = Label(type: .subTitleDescription)
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
extension LargeSquareCollectionCell {
    
    func updateNearbyStoreSection(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.description
    }
}

//MARK: - Layout
extension LargeSquareCollectionCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
