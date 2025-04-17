//
//  NestedCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/9/24.
//

import UIKit

class NestedCell: UITableViewCell {
    
    private let descriptionLabel = Label(type: .highlighted)
    private let photoImageView = ImageView(type: .common)
    
    private lazy var exploreButton = CustomButton(
        title: Text.Home.explore,
        backgroundColor: .white,
        titleColor: .black,
        font: UIFont.systemFont(ofSize: 16, weight: .medium)
    )
    
    private var gradientView: GradientView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onExploreButtonTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView?.frame = contentView.bounds
    }
}
//MARK: - Event Handler
extension NestedCell {
    
    func setupButtonActions() {
        exploreButton.onButtonTapped = { [weak self] in
            self?.onExploreButtonTapped?()
        }
    }
}

//MARK: - Public
extension NestedCell {
    
    func updateHomeCell(with model: NewFromNikeModel, addGradient: Bool) {
        
        descriptionLabel.text = model.logoTitle
        photoImageView.image = UIImage(named: model.image ?? "")

        if addGradient {
            if gradientView == nil {
                let gradient = GradientView()
                contentView.insertSubview(gradient, aboveSubview: photoImageView)
                self.gradientView = gradient
            }
            gradientView?.isHidden = false
        } else {
            gradientView?.isHidden = true
        }
    }
    
    func updateShopCell(with model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
}

// MARK: - Layout
extension NestedCell {
    
    func setupView() {
        [photoImageView, descriptionLabel, exploreButton].forEach { contentView.addSubview($0) }
        
        exploreButton.customButton.layer.borderWidth = 0
        exploreButton.customButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupConstraints() {
        exploreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
           
            descriptionLabel.leadingAnchor.constraint(equalTo: exploreButton.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -16),
            
            exploreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            exploreButton.widthAnchor.constraint(equalToConstant: 90),
            exploreButton.heightAnchor.constraint(equalToConstant: 35),
            exploreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)
        ])
    }
}


