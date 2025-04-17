//
//  PageControlCollectionViewCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/9/24.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {

    private let pageControlImageView = ImageView(type: .pageControl)
    private let pageControlTitleLabel = Label(type: .banner)
    private let pageControlDescriptionLabel = Label(type: .subTitleDescription)

    private func createStackView(with views: [UIView], 
                                 axis: NSLayoutConstraint.Axis,
                                 spacing: CGFloat,
                                 alignment: UIStackView.Alignment = .fill,
                                 layoutMargins: UIEdgeInsets = .zero,
                                 isMarginsRelative: Bool = false) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.isLayoutMarginsRelativeArrangement = isMarginsRelative
       
        if isMarginsRelative {
            stackView.layoutMargins = layoutMargins
        }
        return stackView
    }

    private lazy var labelsStackView: UIStackView = createStackView(
        with: [pageControlTitleLabel, pageControlDescriptionLabel],
        axis: .vertical,
        spacing: 4,
        alignment: .leading,
        layoutMargins: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8),
        isMarginsRelative: true
    )

    private lazy var containerStackView: UIStackView = createStackView(
        with: [pageControlImageView, labelsStackView],
        axis: .horizontal,
        spacing: 12,
        alignment: .center
    )

    private let backgroundContainerView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.adjustBrightness(by: 0.300)
        view.layer.cornerRadius = 6
        view.configureShadow(color: .lightGray, 
                             opacity: 0.2,
                             offset:  CGSize(width: 0, height: 2), 
                             radius: 2)
        view.isShadowEnabled = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLeftCornerRadius(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: radius, height: radius))
       
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageControlImageView.layoutIfNeeded()
        addLeftCornerRadius(to: pageControlImageView, radius: 6)
    }
}

//MARK: - Public
extension PromoCollectionViewCell {

    func updatePageControl(_ model: Product) {
        pageControlImageView.image = UIImage(named: model.image ?? "")
        pageControlTitleLabel.text = model.type
        pageControlDescriptionLabel.text = model.description
    }
}

// MARK: - Layout
extension PromoCollectionViewCell {

    private func setupViews() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(containerStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControlImageView.heightAnchor.constraint(equalTo: backgroundContainerView.heightAnchor),

            backgroundContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            backgroundContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backgroundContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            backgroundContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            containerStackView.topAnchor.constraint(equalTo: backgroundContainerView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: backgroundContainerView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: backgroundContainerView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: backgroundContainerView.bottomAnchor)
        ])
    }
}

