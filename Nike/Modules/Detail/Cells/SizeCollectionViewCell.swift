//
//  SizeCollectionViewCell.swift
//  Nike
//
//  Created by Александр Милейчик on 3/1/25.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    
    private let sizeLabel = Label(type: .banner)
    
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
extension SizeCollectionViewCell {
    func update(_ model: ProductSize) {
        sizeLabel.text = model.size
    }
}

// MARK: - Layout
extension SizeCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(sizeLabel)
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4
    }
    
    func setupConstraints() {
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sizeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sizeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
