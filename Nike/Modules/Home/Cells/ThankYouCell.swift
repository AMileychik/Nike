//
//  ThankYouCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/2/24.
//

import UIKit

class ThankYouCell: UITableViewCell {
    
    private let photoImageView = ImageView(type: .thankYou)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public
extension ThankYouCell {
    func update(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
}

// MARK: - Layout
extension ThankYouCell {
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}


