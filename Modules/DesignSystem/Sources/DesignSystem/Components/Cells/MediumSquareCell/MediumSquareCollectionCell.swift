//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

import UIKit
//import DesignSystem
import AppDomain

public final class MediumSquareCollectionCell: UICollectionViewCell {
   
    public let photoImageView = ImageView(type: .mediumSquareCell)
    public let nameLabel = Label(type: .subTitleDescription)
    public let descriptionLabel = Label(type: .titleDescription)
    public let storeHours = Label(type: .titleDescription)
    public let horizontalStackView = StackView(type: .productCell)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension MediumSquareCollectionCell {
    
    public func updateNearbyStoreSection(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.description
        descriptionLabel.text = model.type
        storeHours.text = model.storeHours
    }
    
    public func updateYouMightAlsoLike(_ model: YouMightAlsoLikeModel) {
        photoImageView.image = UIImage(named: model.image)
    }
}

// MARK: - Layout
extension MediumSquareCollectionCell {
    
    public func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        
        [nameLabel, descriptionLabel, storeHours].forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
}
