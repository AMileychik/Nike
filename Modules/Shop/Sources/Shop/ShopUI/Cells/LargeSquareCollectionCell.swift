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
//public final class LargeSquareCollectionCell: UICollectionViewCell {
//    
//    private let photoImageView = ImageView(type: .nearbySection)
//    private let nameLabel = Label(type: .subTitleDescription)
//    private let horizontalStackView = StackView(type: .productCell)
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
////MARK: - Public
//public extension LargeSquareCollectionCell {
//    
//    func updateNearbyStoreSection(_ model: Product) {
//        photoImageView.image = UIImage(named: model.image ?? "")
//        nameLabel.text = model.description
//    }
//}
//
////MARK: - Layout
//private extension LargeSquareCollectionCell {
//    
//    func setupViews() {
//        backgroundColor = .systemBackground
//        contentView.addSubview(photoImageView)
//        contentView.addSubview(horizontalStackView)
//        horizontalStackView.addArrangedSubview(nameLabel)
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            
//            horizontalStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
//            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//        ])
//    }
//}
