//
//  ShopListCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/17/25.
//

import UIKit

class NewsCell: UITableViewCell {

    var onPhotoTapped: (() -> Void)?
    
    private var shopListData: [Product] = []
    
    private let photoImageView = ImageView(type: .common)
    private let logoImage = ImageView(type: .smallSquare)
    private let nameLabel = Label(type: .header)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhotoImageTappedAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoImageTapped))
        photoImageView.addGestureRecognizer(tapGesture)
        photoImageView.isUserInteractionEnabled = true
    }
    
    @objc private func photoImageTapped() {
        onPhotoTapped?()
    }
}

//MARK: - Public
extension NewsCell {
    
    func updateShopListCell(with model: Product) {
        photoImageView.image = model.image?.isEmpty == false ? UIImage(named: model.image ?? "") : nil
        logoImage.image = model.logoImage?.isEmpty == false ? UIImage(named: model.logoImage ?? "") : nil
        nameLabel.text = model.type
    }
}

// MARK: - Layout
extension NewsCell {
    
    func setupView() {
        [photoImageView, logoImage, nameLabel].forEach { contentView.addSubview($0) }
        nameLabel.textColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            nameLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 24),
        ])
    }
}

