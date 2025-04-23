//
//  MediumSquareCollectionViewCell.swift
//  Nike
//
//  Created by Александр Милейчик on 2/27/25.
//

import UIKit

class MediumSquareCollectionCell: UICollectionViewCell {
   
    private let photoImageView = ImageView(type: .mediumSquareCell)
    private let nameLabel = Label(type: .subTitleDescription)
    private let descriptionLabel = Label(type: .titleDescription)
    private let storeHours = Label(type: .titleDescription)
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
extension MediumSquareCollectionCell {
    
    func updateNearbyStoreSection(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.description
        descriptionLabel.text = model.type
        storeHours.text = model.storeHours
    }
    
    func updateYouMightAlsoLike(_ model: YouMightAlsoLikeModel) {
        photoImageView.image = UIImage(named: model.image)
    }
}

//MARK: - Layout
extension MediumSquareCollectionCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(nameLabel)
        horizontalStackView.addArrangedSubview(descriptionLabel)
        horizontalStackView.addArrangedSubview(storeHours)
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
