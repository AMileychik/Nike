//
//  CategoriesCollectionViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 11/14/24.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .smallSquare)
    
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
extension CategoriesCollectionViewCell {
    
    func updateCategories(_ model: Categories) {
        photoImageView.image = UIImage(named: model.categoryImage ?? "")
    }
}

// MARK: - Layout
extension CategoriesCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(photoImageView)
        
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.layer.borderWidth = 1
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 4
    }
    
    func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}
