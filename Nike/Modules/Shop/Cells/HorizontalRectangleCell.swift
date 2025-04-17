//
//  NewThisWeekCollectionCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 1/23/25.
//

import UIKit

class HorizontalRectangleCell: UICollectionViewCell {
    
    private let photoImageView = ImageView(type: .newThisWeek)
    private let titleDescription = Label(type: .titleDescription)
    private let subTitleDescription = Label(type: .subTitleDescription)
    private let horizontalStackView = StackView(type: .productCell)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public
extension HorizontalRectangleCell {
    
    func updateNewAndFeaturedSection(_ model: Product) {
        photoImageView.image = UIImage(named: model.image ?? "")
        subTitleDescription.text = model.description
        titleDescription.text = model.type
    }
}

//MARK: - Layout
extension HorizontalRectangleCell {
    
    func setupViews() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(titleDescription)
        horizontalStackView.addArrangedSubview(subTitleDescription)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
