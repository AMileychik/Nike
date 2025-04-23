//
//  TopPicksCollectionCell.swift
//  Nike
//
//  Created by Александр Милейчик on 1/13/25.
//

import UIKit

enum DataType {
    case productModel(_ model: [Product])
}

class BecauseYouLikeCollectionCell: UICollectionViewCell {
    
    private var dataType: DataType?
    
    private let photoImageView = ImageView(type: .product)
    private let nameLabel = Label(type: .subTitleDescription)
    private let descriptionLabel = Label(type: .titleDescription)
    private var priceLabel = Label(type: .subTitleDescription)
    private let horizontalStackView = StackView(type: .productCell)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
        photoImageView.image = nil
    }
}

//MARK: - Public
extension BecauseYouLikeCollectionCell {
    
    func update(dataType: DataType) {
        self.dataType = dataType
        switch dataType {
            
        case .productModel(let models):
            guard let model = models.first else { return }
            update(with: model)
        }
    }
    
    private func update(with model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        nameLabel.text = model.type
        descriptionLabel.text = model.description
        
        if let price = model.price {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = nil
        }
    }
}

//MARK: - Layout
extension BecauseYouLikeCollectionCell {
    
    private func setupViews() {
        backgroundColor = .systemBackground
        photoImageView.layer.cornerRadius = 6
        horizontalStackView.spacing = 4
        
        [photoImageView, horizontalStackView].forEach { contentView.addSubview($0) }
        [nameLabel, descriptionLabel, priceLabel].forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
