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
//public final class ClassicsSpotlightCollectionViewCell: UICollectionViewCell {
//    
//    private let photoImageView = ImageView(type: .product)
//    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - Public
//public extension ClassicsSpotlightCollectionViewCell {
//    
//    func update(_ model: Product) {
//        photoImageView.image = UIImage(named: model.image ?? "")
//    }
//}
//
//// MARK: - Layout
//private extension ClassicsSpotlightCollectionViewCell {
//    
//    func setupViews() {
//        backgroundColor = .systemBackground
//        contentView.addSubview(photoImageView)
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            photoImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}
