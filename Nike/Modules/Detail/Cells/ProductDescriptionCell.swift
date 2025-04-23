//
//  ProductDescription.swift
//  Nike
//
//  Created by Александр Милейчик on 12/14/24.
//

import UIKit

final class ProductDescriptionCell: UITableViewCell {
    
    private let titleLabel = Label(type: .subTitleDescription)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) не был реализован")
    }
}

// MARK: - Public
extension ProductDescriptionCell {
    
    func update(_ model: ProductDescription) {
        titleLabel.text = model.description
    }
}

//MARK: - Layout
extension ProductDescriptionCell {
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
