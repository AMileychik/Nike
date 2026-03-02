//
//  TopPicksCollectionCell.swift
//  Nike
//
//  Created by Александр Милейчик on 1/13/25.
//

import UIKit
import AppDomain
import DesignSystem

// MARK: - Public

/// UICollectionViewCell for displaying a BecauseYouLike item.
/// Generic over `Item` conforming to `BecauseYouLikeItemModelProtocol`.
final class CarouselCollectionCell<Item: AnyItemProtocol>: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let photoImageView = ImageView(type: .product)
    private let nameLabel = Label(type: .subTitleDescription)
    private let descriptionLabel = Label(type: .titleDescription)
    private let priceLabel = Label(type: .subTitleDescription)
    private let horizontalStackView = StackView(type: .productCell)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
        photoImageView.image = nil
        priceLabel.text = nil
    }
}

// MARK: - Public Methods

extension CarouselCollectionCell {
    
    /// Updates cell content with provided item
    /// - Parameter item: Item model conforming to `BecauseYouLikeItemModelProtocol`
    func update(with item: Item) {        
        nameLabel.text = item.title
        descriptionLabel.text = item.subtitle
        
        if let imageURL = item.imageURL {
            photoImageView.image = UIImage(named: imageURL)
        } else {
            photoImageView.image = nil
        }
        
        if let price = item.priceLabel {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = nil
        }
    }
}

// MARK: - Layout Setup

private extension CarouselCollectionCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        
        photoImageView.layer.cornerRadius = Constants.imageCornerRadius
        
        horizontalStackView.spacing = Constants.stackSpacing
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        
        [nameLabel, descriptionLabel, priceLabel].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        [photoImageView, horizontalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Image
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            // Text stack
            horizontalStackView.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: Constants.stackTopSpacing
            ),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Layout Constants

private enum Constants {
    static let imageCornerRadius: CGFloat = 6
    static let stackSpacing: CGFloat = 4
    static let stackTopSpacing: CGFloat = 8
}


