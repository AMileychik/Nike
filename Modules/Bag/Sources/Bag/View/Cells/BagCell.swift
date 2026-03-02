//
//  File.swift
//
//
//  Created by Александр Милейчик on 6/20/25.
//

import UIKit
import DesignSystem

public final class BagCell: UITableViewCell {
    
    // MARK: - Properties
    private let photoImageView = ImageView(type: .common)
    private let titleLabel = Label(type: .title)
    private let descriptionLabel = Label(type: .titleDescription)
    private let priceLabel = Label(type: .subtitle)
    private let separatorView = UIView.makeSeparator()
    
    private lazy var quantityButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(quantityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var uiModel: BagProductUIModel?
    
    public weak var delegate: BagCellDelegate?
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureQuantityButton(count: Double) {
        var config = UIButton.Configuration.plain()
        config.title = "Qty \(Int(count))"
        config.baseForegroundColor = .black
        config.contentInsets = .zero
        config.image = UIImage(systemName: "chevron.down")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        quantityButton.configuration = config
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        priceLabel.text = nil
        quantityButton.configuration = nil
    }
}

// MARK: - Action Handler
extension BagCell {
    @objc private func quantityButtonTapped() {
        guard let model = uiModel else { return }
        delegate?.didRequestEditQuantity(for: model)
    }
}

// MARK: - Public
extension BagCell {
    
    public func configure(with model: BagProductUIModel, isLast: Bool) {
        self.uiModel = model
        
        guard let price = model.price, let count = model.count else { return }
        
        photoImageView.image = UIImage(named: model.image ?? "")
        titleLabel.text = model.title
        descriptionLabel.text = model.category
        priceLabel.text = String(format: "$%.2f", price * count)
        
        configureQuantityButton(count: model.count ?? 0.0)
        
        separatorView.isHidden = isLast
    }
}

// MARK: - Layout
extension BagCell {
    private func setupViews() {
        [photoImageView, titleLabel, descriptionLabel, quantityButton, priceLabel, separatorView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let minHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 240)
        minHeightConstraint.priority = .defaultLow
        minHeightConstraint.isActive = true
        
        quantityButton.contentHorizontalAlignment = .left
        [quantityButton, separatorView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 24),
            
            quantityButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 6),
            quantityButton.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            quantityButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            priceLabel.centerYAnchor.constraint(equalTo: quantityButton.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
