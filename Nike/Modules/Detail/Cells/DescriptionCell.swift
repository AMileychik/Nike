//
//  Description.swift
//  Nike
//
//  Created by Александр Милейчик on 3/1/25.
//

import UIKit

final class DescriptionCell: UITableViewCell {

    private let titleLabel = Label(type: .header)
    private let descriptionLabel = Label(type: .subTitleDescription)
    private let priceLabel = Label(type: .priceLabel)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension DescriptionCell {
    
    func update(_ model: Product) {
        titleLabel.text = model.type
        descriptionLabel.text = model.description
       
        if let price = model.price {
            priceLabel.text = String(format: "$%.2f", Double(price))
        } else {
            priceLabel.text = nil
        }
    }
    
    func update2(_ model: Description) {
        titleLabel.text = model.type
        descriptionLabel.text = model.description
    }
}

// MARK: - Layout
extension DescriptionCell {
    
    func setupViews() {
        [titleLabel, descriptionLabel, priceLabel].forEach { contentView.addSubview($0) }
        descriptionLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -12)
        ])
    }
}

