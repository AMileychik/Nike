//
//  File.swift
//  
//
//  Created by Александр Милейчик on 7/6/25.
//

//import UIKit
//import AppDomain
//import DesignSystem
//
//public final class NewsCell: UITableViewCell {
//    
//    private let photoImageView = ImageView(type: .common)
//    private let logoImage = ImageView(type: .smallSquare)
//    private let nameLabel = Label(type: .header)
//    
//    public var onPhotoTapped: (() -> Void)?
//    
//    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    public func setupPhotoImageTappedAction() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoImageTapped))
//        photoImageView.addGestureRecognizer(tapGesture)
//        photoImageView.isUserInteractionEnabled = true
//    }
//    
//    @objc private func photoImageTapped() {
//        onPhotoTapped?()
//    }
//}
//
//// MARK: - Public
//public extension NewsCell {
//    
//    func updateNewsCell(with model: Product) {
//        photoImageView.image = model.image?.isEmpty == false ? UIImage(named: model.image ?? "") : nil
//        logoImage.image = model.logoImage?.isEmpty == false ? UIImage(named: model.logoImage ?? "") : nil
//        nameLabel.text = model.type
//    }
//}
//
//// MARK: - Layout
//private extension NewsCell {
//    
//    func setupView() {
//        [photoImageView, logoImage, nameLabel].forEach { contentView.addSubview($0) }
//        nameLabel.textColor = .white
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
//            
//            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            
//            nameLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 24),
//        ])
//    }
//}
