//
//  CompleteTheLookCollectionViewCell.swift
//  Nike
//
//  Created by Александр Милейчик on 3/5/25.
//

import UIKit

final class CompleteTheLookCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .completeTheLook)
    
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
extension CompleteTheLookCollectionViewCell {
    
    func update(_ model: CompleteTheLookModel) {
        photoImageView.image = UIImage(named: model.image)
    }
}

//MARK: - Layout
extension CompleteTheLookCollectionViewCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.backgroundColor = UIColor.lightGray.adjustBrightness(by: 0.150)
        photoImageView.layer.cornerRadius = 6
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}

