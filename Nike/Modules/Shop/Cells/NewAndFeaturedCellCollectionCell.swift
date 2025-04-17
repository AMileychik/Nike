//
//  NewAndFeatureCellCollectionViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/24/25.
//

import UIKit

class NewAndFeaturedCellCollectionCell: UICollectionViewCell {
  
    private let photoImageView = ImageView(type: .product)
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
extension NewAndFeaturedCellCollectionCell {
    
    func updateNewAndFeaturedSection(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.description
    }
}

//MARK: - Layout
extension NewAndFeaturedCellCollectionCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
