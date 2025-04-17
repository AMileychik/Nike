//
//  TemporaryPromotionCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 12/19/24.
//

import UIKit

final class TotalPriceCell: UITableViewCell {
    
    private let subtotalTitleLabel = Label(type: .subTitleDescription)
    private let totalPriceValueLabel = Label(type: .subTitleDescription)
    private let separatorView = UIView.makeSeparator()
    
    var totalPrice: Double = 0.0 {
        didSet {
            subtotalTitleLabel.text = Text.Bag.subtotal
            totalPriceValueLabel.text = String(format: "$%.2f + Tax", totalPrice)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        totalPrice = 0.0
    }
}

// MARK: - Layout
extension TotalPriceCell {
    
    private func setupViews() {
        [subtotalTitleLabel, totalPriceValueLabel, separatorView].forEach { contentView.addSubview($0) }
    }
    private func setupConstraints() {
        [subtotalTitleLabel, totalPriceValueLabel, separatorView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([            
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            subtotalTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            subtotalTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            subtotalTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            totalPriceValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            totalPriceValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            totalPriceValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}

