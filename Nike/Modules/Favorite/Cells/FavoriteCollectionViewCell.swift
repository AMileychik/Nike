//
//  FavoriteCollectionViewCell2.swift
//  LagomStore
//
//  Created by Александр Милейчик on 2/24/25.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .common)
    private let descriptionLabel = Label(type: .subTitleDescription)
    private let priceLabel = Label(type: .subtitle)
    private let horizontalStackView = StackView(type: .headerStackView)
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.backgroundColor = .clear
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()

    var onRemoveFromFavorites: (() -> Void)?
    var onSelectItem: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Action Handler
extension FavoriteCollectionViewCell {
    
    @objc private func deleteButtonTapped() {
        let currentImageName = deleteButton.imageView?.image == UIImage(systemName: "heart.fill") ? "heart" : "heart.fill"
        deleteButton.setImage(UIImage(systemName: currentImageName), for: .normal)
        onRemoveFromFavorites?()
    }
}

//MARK: - Public
extension FavoriteCollectionViewCell {
    
    func update(_ model: SubCategoryModel, isEditing: Bool) {
        deleteButton.isHidden = !isEditing
        
        photoImageView.image = UIImage(named: model.subCategoryImage ?? "")
        descriptionLabel.text = model.title
       
        if let price = model.price {
            priceLabel.text = String(format: "$%.2f", price)
        } else {
            priceLabel.text = nil
        }
    }
}

//MARK: - Layout
extension FavoriteCollectionViewCell {

    private func setupViews() {
        backgroundColor = .systemBackground
        
        [photoImageView, deleteButton, horizontalStackView].forEach { contentView.addSubview($0) }
        [descriptionLabel, priceLabel].forEach { horizontalStackView.addArrangedSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.70),

            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            deleteButton.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

