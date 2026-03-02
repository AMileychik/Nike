//
//  NestedCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/9/24.
//

import UIKit
import DesignSystem
import AppDomain
import AppCore

// MARK: - Public

final class NestedCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let descriptionLabel = Label(type: .highlighted)
    private let photoImageView = ImageView(type: .common)
    private var gradientView: GradientView?
    
    private lazy var exploreButton = CustomButton(
        title: Text.Home.explore,
        backgroundColor: .white,
        titleColor: .black,
        font: UIFont.systemFont(ofSize: 16, weight: .medium)
    )
    
    // MARK: - Callbacks
    
    var onExploreButtonTapped: (() -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView?.frame = contentView.bounds
    }
}

// MARK: - Public Methods

extension NestedCell {
    
    /// Updates cell for Home screen usage
    func updateHomeCell(with props: ProductProps, addGradient: Bool) {
        descriptionLabel.text = props.logoTitle
        photoImageView.image = UIImage(named: props.image)
        updateGradientVisibility(addGradient)
    }
    
    /// Updates cell for Shop screen usage
    func updateShopCell(with model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
    }
}

// MARK: - Actions

private extension NestedCell {
    
    func configureActions() {
        exploreButton.onButtonTapped = { [weak self] in
            self?.onExploreButtonTapped?()
        }
    }
}

// MARK: - Layout Setup

private extension NestedCell {
    
    func configureView() {
        [photoImageView, descriptionLabel, exploreButton].forEach {
            contentView.addSubview($0)
        }
        
        exploreButton.customButton.layer.borderWidth = 0
        exploreButton.customButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configureLayout() {
        exploreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Image
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.imageBottomInset),
            
            // Description
            descriptionLabel.leadingAnchor.constraint(equalTo: exploreButton.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -Constants.descriptionBottomSpacing),
            
            // Button
            exploreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.buttonLeading),
            exploreButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            exploreButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            exploreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.buttonBottom)
        ])
    }
}

// MARK: - Gradient Handling

private extension NestedCell {
    
    func updateGradientVisibility(_ isVisible: Bool) {
        if isVisible {
            if gradientView == nil {
                let gradient = GradientView()
                contentView.insertSubview(gradient, aboveSubview: photoImageView)
                gradientView = gradient
            }
            gradientView?.isHidden = false
        } else {
            gradientView?.isHidden = true
        }
    }
}

// MARK: - Layout Constants

private enum Constants {

    // Image
    static let imageBottomInset: CGFloat = 4

    // Description
    static let descriptionBottomSpacing: CGFloat = 16

    // Button
    static let buttonLeading: CGFloat = 24
    static let buttonWidth: CGFloat = 90
    static let buttonHeight: CGFloat = 35
    static let buttonBottom: CGFloat = 36
}




//import UIKit
//
//import DesignSystem
//import AppDomain
//import AppCore
//
//class NestedCell: UITableViewCell {
//    
//    private let descriptionLabel = Label(type: .highlighted)
//    private let photoImageView = ImageView(type: .common)
//    private var gradientView: GradientView?
//    
//    private lazy var exploreButton = CustomButton(
//        title: Text.Home.explore,
//        backgroundColor: .white,
//        titleColor: .black,
//        font: UIFont.systemFont(ofSize: 16, weight: .medium)
//    )
//    
//    var onExploreButtonTapped: (() -> Void)?
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
//        setupConstraints()
//        setupButtonActions()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientView?.frame = contentView.bounds
//    }
//}
//
////MARK: - Event Handler
//
//extension NestedCell {
//    func setupButtonActions() {
//        exploreButton.onButtonTapped = { [weak self] in
//            self?.onExploreButtonTapped?()
//        }
//    }
//}
//
////MARK: - Public
//
//extension NestedCell {
//    func updateHomeCell(with props: ProductProps, addGradient: Bool) {
//
//        descriptionLabel.text = props.logoTitle
//        photoImageView.image = UIImage(named: props.image)
//
//        if addGradient {
//            if gradientView == nil {
//                let gradient = GradientView()
//                contentView.insertSubview(gradient, aboveSubview: photoImageView)
//                gradientView = gradient
//            }
//            gradientView?.isHidden = false
//        } else {
//            gradientView?.isHidden = true
//        }
//    }
//    
//    func updateShopCell(with model: Product) {
//        photoImageView.image = UIImage(named: model.image ?? "")
//    }
//}
//
//// MARK: - Layout
//
//extension NestedCell {
//    func setupView() {
//        [photoImageView, descriptionLabel, exploreButton].forEach { contentView.addSubview($0) }
//        
//        exploreButton.customButton.layer.borderWidth = 0
//        exploreButton.customButton.layer.borderColor = UIColor.clear.cgColor
//    }
//    
//    func setupConstraints() {
//        exploreButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
//            
//            descriptionLabel.leadingAnchor.constraint(equalTo: exploreButton.leadingAnchor),
//            descriptionLabel.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -16),
//            
//            exploreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
//            exploreButton.widthAnchor.constraint(equalToConstant: 90),
//            exploreButton.heightAnchor.constraint(equalToConstant: 35),
//            exploreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36)
//        ])
//    }
//}

